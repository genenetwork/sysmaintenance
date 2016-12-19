The following are instructions on how to update the SnpAll table from mm9 to mm10.

---

1. All a new column "Position_2016 (or whatever the year is)" to the SnpAll table in the Rabbit database that will be a back-up of the previous position data. The SQL to do this is the following (though database editing software can be used instead):
  ```
  ALTER TABLE SnpAll
  ADD COLUMN Position_2016 DOUBLE
  AFTER Position;
  ```
   
  This query should last about 20 minutes.

2. Duplicate the current contents of "Position" into the new column "Position_2016". The SQL for this is the following:
   ```
   UPDATE SnpAll
   SET SnpAll.`Position_2016` = SnpAll.`Position`;
   ```

   This query should last about 60 minutes.

3. Get the latest Mouse SNPs (build 146) from dbSNP from [this link](ftp.ncbi.nih.gov/snp/organisms/mouse_10090/database/organism_data/b146_SNPChrPosOnRef.bcp.gz).
   About 80,443,388 records vs 9,848,309 currently in genenetwork database table SnpAll

4. Convert the base pair values to Mb using the following command (run from the command line):
   ```
   awk '{ OFS = "\t" ; print $1, $2/1000000, $3/1000000, $4}' b146_SNPChrPosOnRef.bcp > rs-position_b146_master.txt
   ```

5. Upload the values into the dummy table Vlookup in the database. The SQL to do so is the following:
   ```
   LOAD DATA INFILE '/home/acenteno/liftover_mm9-mm10/rs-position_b146_master.txt' INTO TABLE Vlookup (SnpName, Position);
   ```

   This query should last about 11 minutes.
   
6. Update the SnpAll table from the Vlookup table. To do this use the following SQL command:
   ```
   UPDATE SnpAll p1, Vlookup p2
   SET p1.Position = p2.Position
   WHERE p1.SnpName = p2.SnpName;
   ```
   
   This query should last about 1 hour.
