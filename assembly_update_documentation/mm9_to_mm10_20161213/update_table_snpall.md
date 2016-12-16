1. SnpAll table on the server Rabbit, new columns: 
  - **Position_2016**
  
  The SQL to do this is the following (though database editing software can be used instead):
  ```
  ALTER TABLE SnpAll
  ADD COLUMN Position_2016 DOUBLE
  AFTER Position;
  ```
   
  These queries should last about 20 minutes.

2. duplicated in these new colums. The SQL for this is the following:
   ```
   UPDATE SnpAll
   SET SnpAll.`Position_2016` = SnpAll.`Position`;
   ```

   This query should last about 60 minutes.


Step 1. Getting the latest SNPs build 146 from dbSNP ONLY for Mouse at:
ftp.ncbi.nih.gov/snp/organisms/mouse_10090/database/organism_data/b146_SNPChrPosOnRef.bcp.gz
About 80,443,388 records vs 9,848,309 currently in genenetwork database table SnpAll

Step 2. Convert the base pair values to Mb

Step 3. Upload the values to the dummy table Vlookup

mysql> LOAD DATA INFILE '/home/acenteno/liftover_mm9-mm10/rs-position_b146_master.txt' INTO TABLE Vlookup (SnpName, Position);
Query OK, 80443388 rows affected (11 min 7.88 sec)
Records: 80443388  Deleted: 0  Skipped: 0  Warnings: 0

Step 4 and final. Perform the vlookup using the following MySQL commands:

mysql> UPDATE SnpAll p1, Vlookup p2
    -> SET p1.Position = p2.Position
    -> WHERE p1.SnpName = p2.SnpName;
Query OK, 9848309 rows affected (59 min 24.68 sec)
Rows matched: 9848361  Changed: 9848309  Warnings: 0
