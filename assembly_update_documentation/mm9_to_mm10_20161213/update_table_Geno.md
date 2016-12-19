The following explains how to update the Geno table before adding in the new assembly data.
___

1. In the Geno table on the server Rabbit, add a new column **Mb_2016**. This column will contain the previous data and its name should always include the current year. 

  The SQL to do this is the following (though database editing software can be used instead):
  ```
  ALTER TABLE Geno
  ADD COLUMN Mb_2016 DOUBLE
  AFTER Mb;
  ```
   
  This query should last about 16 sec.

2. Duplicate the data currently in the **Mb** column into the **Mb_2016** column. The SQL for this is the following:
   ```
   UPDATE Geno
   SET Geno.`Mb_2016` = Geno.`Mb`;
   ```

   This query should last about 11 sec.

3. Export the current mm9 values for Mouse (SpeciesId=1) to a text file. This represents only 35061 out of 483027 total rows in the Geno table. The SQL to export these mm9 locations is the following:
   ```
   SELECT Id, Marker_Name, Chr, Mb 
   FROM Geno
   WHERE SpeciesId=1
   ORDER BY Id ASC INTO OUTFILE '/tmp/Geno_Table_mm9.txt' FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';
   ```

   This query should take less than a second.

4. Convert the Mb values to base pairs. This can be done with the following line:
   ```
   awk '{ OFS = "\t" ; printf ("%.10g\n", $2*1000000)}' Geno_Table_Mb_mm9.txt > Geno_Table_mm9.bed
   ```

5. Use the web tool at http://genome.ucsc.edu/cgi-bin/hgLiftOver to convert the .bed file from the previous step (Geno_Table_mm9.bed) to mm10. The first drop-downs should be set to the following:
   - Original Genome: Mouse
   - Original Assembly: July 2007 (NCBI38/mm9)
   - New Genome: Mouse
   - New Assembly: Dec. 2011 (GRCm38/mm10)
   
   Leave the other options as is and upload your .bed file with the "Choose File" button at the bottom of the page. Then click "Submit File". The tool will then give you a .bed file with a randomized filename. 
   
   Note that mm9 positions without corresponding mm10 positions will be excluded from the resulting file. We include the Id in the input file in order to identify which traits were excluded.

6. Load the data in the output file from the previous step into the dummy table Vlookup in the database. The SQL to do so is the following (substituting "ucsc_liftover_results.bed" with the file you received from the previous step):
   ```
   LOAD DATA
   INFILE '/home/acenteno/liftover_mm9-mm10/ucsc_liftover_results.bed'
   INTO TABLE Vlookup (Id, Mb);
   ```

   This query should take less than a second.

   Vlookup should now contain something similar to the following (with the first 10 rows listed):

   Id | Mb         
   ----|----
   1 | 4.688207 
   2 | 6.469816 
   8 | 38.996112 
   9 | 44.213881 
   10 | 49.302433 
   12 | 54.095723 
   13 | 61.839045 
   17 | 72.877041 
   21 | 93.622085 
   25 | 107.517268 

7. Replace the old Mb values (mm9) with the new ones (mm10). The SQL to do so is the following:
   ```
   UPDATE Geno p1, Vlookup p2
   SET p1.Mb = p2.Mb
   WHERE p1.Id = p2.Id;
   ```

   This query should take less than a second.

8. For testing purposes, try re-running QTL reaper for the dataset GN112 (BXD Hippocampus Consortium M430v2 (Jun06) PDNN) using the python script QTL_Reaper_v6.py. Do this with the following line:
   ```
   python QTL_Reaper_v6.py 112
   ```

   If it then returns "lrs=(40 2000) 2634 records" the liftover was done successfully.
