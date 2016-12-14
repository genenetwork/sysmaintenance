1. Create new GN1 archive (2016-12-12) using Time Machine: http://artemis-20161212.genenetwork.org/
Past versions can be accessed through http://artemis.uthsc.edu/

2. Synchronize the server Rabbit's database and code with Lily's. The following files document how to do this:
Source code - https://github.com/genenetwork/sysmaintenance/blob/master/gn_update_src/gnupdatesrc_from_lily.sh
Database - https://github.com/genenetwork/sysmaintenance/blob/master/gn_update_db/gnupdatedb_from_lily.sh

3. Add new columns in the database for the previous assembly versions in the ProbeSet table on the server Rabbit. These new columns should correspond with the following existing columns: Chr, Mb, Probe_set_Blat_Mb_start, Probe_set_Blat_Mb_end

   The names for the new columns should then include the current year. For example: Chr_2016, Mb_2016, Probe_set_Blat_Mb_start_2016, Probe_set_Blat_Mb_end_2016

   The SQL to do this is the following (though database editing software can be used instead):
   ```
       ALTER TABLE ProbeSet 
       ADD COLUMN Chr_2016 CHAR(3) AFTER Mb
       ADD COLUMN Mb_2016 double AFTER Chr_2016
       ADD COLUMN Probe_set_Blat_Mb_start_2016 double AFTER Mb_2016
       ADD COLUMN Probe_set_Blat_Mb_end_2016 double AFTER Probe_set_Blat_Mb_start_2016
   ```
    
   This query should last about 10 minutes.

4. The data in Chr, Mb, Probe_set_Blat_Mb_start, and Probe_set_Blat_Mb_end should be duplicated in these new colums. The SQL for this is the following:
   ```
    UPDATE ProbeSet
    SET ProbeSet.`Chr_2016`                     = ProbeSet.`Chr`,
        ProbeSet.`Mb_2016`                      = ProbeSet.`Mb`,
        ProbeSet.`Probe_set_Blat_Mb_start_2016` = ProbeSet.`Probe_set_Blat_Mb_start`,
        ProbeSet.`Probe_set_Blat_Mb_end_2016`	= ProbeSet.`Probe_set_Blat_Mb_end`;
   ```

   This query should last about 3 minutes.