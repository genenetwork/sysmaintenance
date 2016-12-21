(Note: The following instructions are mostly the same for updating all tables prior to adding the new assembly data. The specific queries for each are just included for maximum clarity.)

The following explains how to update the BxdSnpPosition table before adding the new assembly data.

___

1. Add a new column **Mb_2016** in the database for the previous assembly versions in the BXDSnpPosition table on the server Rabbit. The name for the new column should include the current year (in this case **Mb_2016**).

   ```
   ALTER TABLE BXDSnpPosition
   ADD COLUMN Mb_2016 DOUBLE
   AFTER Mb;
   ```

   This query should take about 2 minutes.

2. The data in the column **Mb** should be duplicated into the new column **Mb_2016**. The SQL for this is the following:
   ```
   UPDATE BXDSnpPosition
   SET BXDSnpPosition.`Mb_2016` = BXDSnpPosition.`Mb`;
   ```

   This query should take about 49 seconds.
