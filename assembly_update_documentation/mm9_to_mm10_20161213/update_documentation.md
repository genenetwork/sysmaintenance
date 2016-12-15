Sometimes we need to update to newly released genome assemblies in GeneNetwork. This file details the process used to update the database accordingly.

---

## How to update assemblies in GeneNetwork



1. Create new GN1 archive (2016-12-12) using Time Machine: http://artemis-20161212.genenetwork.org/

   Past archives can be accessed through http://artemis.uthsc.edu/

2. Synchronize the server Rabbit's database and code with Lily's. The following scripts are used to do this:
   * Source code sync script - [GitHub](https://github.com/genenetwork/sysmaintenance/blob/master/gn_update_src/gnupdatesrc_from_lily.sh)
   * Database sync script - [GitHub](https://github.com/genenetwork/sysmaintenance/blob/master/gn_update_db/gnupdatedb_from_lily.sh)

3. Add new columns in the database for the previous assembly versions in the ProbeSet table on the server Rabbit. These new columns should correspond with the following existing columns: 
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
       ADD COLUMN Chr_2016 CHAR(3) AFTER Mb
       
       ALTER TABLE ProbeSet
       ADD COLUMN Mb_2016 double AFTER Chr_2016
       
       ALTER TABLE ProbeSet
       ADD COLUMN Probe_set_Blat_Mb_start_2016 double AFTER Mb_2016
       
       ALTER TABLE ProbeSet
       ADD COLUMN Probe_set_Blat_Mb_end_2016 double AFTER Probe_set_Blat_Mb_start_2016
   ```
    
   These queries should last about 10 minutes.

4. The data in Chr, Mb, Probe_set_Blat_Mb_start, and Probe_set_Blat_Mb_end should be duplicated in these new colums. The SQL for this is the following:
   ```
    UPDATE ProbeSet
    SET ProbeSet.`Chr_2016`                     = ProbeSet.`Chr`,
        ProbeSet.`Mb_2016`                      = ProbeSet.`Mb`,
        ProbeSet.`Probe_set_Blat_Mb_start_2016` = ProbeSet.`Probe_set_Blat_Mb_start`,
        ProbeSet.`Probe_set_Blat_Mb_end_2016`	= ProbeSet.`Probe_set_Blat_Mb_end`;
   ```

   This query should last about 3 minutes.

5. Select only the microarray platforms for Species = 1 (Mouse), export Id, Chr, Probe_set_Blat_Mb_start, Probe_set_Blat_Mb_end values from ProbeSet table with Species =1 (Mouse) to a text file.
```
SELECT ProbeSet.`Id`,ProbeSet.`Chr`,ProbeSet.`Probe_set_Blat_Mb_start`,ProbeSet.`Probe_set_Blat_Mb_end`
FROM ProbeSet,GeneChip
WHERE ProbeSet.`ChipId`=GeneChip.`Id`
AND GeneChip.`SpeciesId`=1
ORDER BY ProbeSet.`Id`
INTO OUTFILE '/tmp/ProbeSet_mm9v5.txt'
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n';
```
Execution Time : 1 min

6. Convert the Mb (megabases) positions to Bp (basepair)
awk '{ OFS = "\t" ; print $1, $2*1000000, $3*1000000, $4}' liftover_mm9_genome_Group1g.bed > liftover_mm9_genome_Group1g_Mb.bed

7. Prepare a .bed file with chrxx start end Id and perform the liftover at http://genome.ucsc.edu/cgi-bin/hgLiftOver

8. LOAD DATA INFILE
```
LOAD DATA INFILE '/home/acenteno/liftover_mm9-mm10/chr-start-end-id_master_liftover_mm10.txt' INTO TABLE Vlookup (Chr, Mb, Probe_set_Blat_Mb_end, Id);
```
17.92 sec

9. Vlookup the data from the dummy table Vlookup to table ProbeSet.

```
UPDATE ProbeSet p1, Vlookup p2
SET p1.Mb = p2.Mb
WHERE p1.Id = p2.Id;
```
Query OK, 2595514 rows affected (2 min 9.89 sec)

```
UPDATE ProbeSet p1, Vlookup p2
SET p1.Probe_set_Blat_Mb_start = p2.Mb
WHERE p1.Id = p2.Id;
```
Query OK, 2595514 rows affected (2 min 10.67 sec)

```
UPDATE ProbeSet p1, Vlookup p2
SET p1.Probe_set_Blat_Mb_end = p2.Probe_set_Blat_Mb_end
WHERE p1.Id = p2.Id;
```
Query OK, 2595473 rows affected (2 min 11.36 sec)
