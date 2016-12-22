(Note: The following instructions are mostly the same for updating all tables prior to adding the new assembly data. The specific queries for each are just included for maximum clarity.)

The following explains how to update the TissueProbeSetXRef table before adding the new assembly data.

___

1. Add a new column **Mb_2016** in the database for the previous assembly versions in the TissueProbeSetXRef table on the server Rabbit. The name for the new column should include the current year (in this case **Mb_2016**). The SQL to do so is the following:
   ```
   ALTER TABLE TissueProbeSetXRef
   ADD COLUMN Mb_2016 DOUBLE
   AFTER Mb;
   ```
   
   This query should take around 4 seconds.
   
2. The data in **Mb_start** should be duplicated in this new column. The SQL for this is the following:
   ```
   UPDATE TissueProbeSetXRef
   SET
   TissueProbeSetXRef.`Mb_2016` = TissueProbeSetXRef.`Mb`;
   ```
   
   This query should take around 2 seconds.
