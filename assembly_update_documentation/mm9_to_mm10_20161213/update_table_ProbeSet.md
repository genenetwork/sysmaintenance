The following explains how to update the ProbeSet table before adding the new assembly data.
___

1. Add new columns in the database for the previous assembly versions in the ProbeSet table on the server Rabbit. These new columns should correspond with the following existing columns: 
   - **Chr**
   - **Mb** 
   - **Probe_set_Blat_Mb_start**
   - **Probe_set_Blat_Mb_end**

  The names for the new columns should include the current year. For example: 
  - **Chr_2016**
  - **Mb_2016** 
  - **Probe_set_Blat_Mb_start_2016**
  - **Probe_set_Blat_Mb_end_2016**

  The SQL to do this is the following (though database editing software can be used instead):
  ```
  ALTER TABLE ProbeSet 
  ADD COLUMN Chr_2016 CHAR(3)
  AFTER Mb;
       
  ALTER TABLE ProbeSet
  ADD COLUMN Mb_2016 double
  AFTER Chr_2016;
       
  ALTER TABLE ProbeSet
  ADD COLUMN Probe_set_Blat_Mb_start_2016 double
  AFTER Mb_2016;
       
  ALTER TABLE ProbeSet
  ADD COLUMN Probe_set_Blat_Mb_end_2016 double
  AFTER Probe_set_Blat_Mb_start_2016;
  ```
   
  These queries should last about 10 minutes.

2. The data in Chr, Mb, Probe_set_Blat_Mb_start, and Probe_set_Blat_Mb_end should be duplicated in these new colums. The SQL for this is the following:
   ```
   UPDATE ProbeSet
   SET ProbeSet.`Chr_2016`                     = ProbeSet.`Chr`,
       ProbeSet.`Mb_2016`                      = ProbeSet.`Mb`,
       ProbeSet.`Probe_set_Blat_Mb_start_2016` = ProbeSet.`Probe_set_Blat_Mb_start`,
       ProbeSet.`Probe_set_Blat_Mb_end_2016`	= ProbeSet.`Probe_set_Blat_Mb_end`;
   ```

   This query should last about 3 minutes.

3. Selecting only the microarray platforms for Mouse (SpeciesId = 1), export the Ids and current location data (Chr, Mb, Probe_set_Blat_Mb_start, Probe_set_Blat_Mb_end) to a .bed file. The SQL for this is the following:
   ```
   SELECT ProbeSet.`Chr`, ProbeSet.`Probe_set_Blat_Mb_start`, ProbeSet.`Probe_set_Blat_Mb_end`, ProbeSet.`Id`
   FROM ProbeSet,GeneChip
   WHERE ProbeSet.`ChipId`=GeneChip.`Id`
   AND GeneChip.`SpeciesId`=1
   ORDER BY ProbeSet.`Id`
   INTO OUTFILE '/tmp/ProbeSet_mm9v5_Mb.bed'
   FIELDS TERMINATED BY '\t'
   LINES TERMINATED BY '\n';
   ```
   
   This query should last about 1 minute.

4. Convert the data in the previously exported file (ProbeSet_mm9v5_Mb.bed) from megabases to base pairs using the following line:
   ```
   awk '{ OFS = "\t" ; print $1, $2*1000000, $3*1000000, $4}' ProbeSet_mm9v5_Mb.bed > ProbeSet_mm9v5_bp.bed
   ```

5. Use the web tool at http://genome.ucsc.edu/cgi-bin/hgLiftOver to convert the .bed file from the previous step (the one in base pairs) to mm10. The first drop-downs should be set to the following:
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
   INTO TABLE Vlookup (Chr, Mb, Probe_set_Blat_Mb_end, Id);
   ```
   
   This query should take about 18 seconds.

7. Update the data in the ProbeSet table from the Vlookup table using the following SQL:
   ```
   UPDATE ProbeSet p1, Vlookup p2
   SET p1.Mb = p2.Mb
   WHERE p1.Id = p2.Id;

   UPDATE ProbeSet p1, Vlookup p2
   SET p1.Probe_set_Blat_Mb_start = p2.Mb
   WHERE p1.Id = p2.Id;

   UPDATE ProbeSet p1, Vlookup p2
   SET p1.Probe_set_Blat_Mb_end = p2.Probe_set_Blat_Mb_end
   WHERE p1.Id = p2.Id;
   ```

   These queries should take about 2 minutes each, or 6 minutes total.
