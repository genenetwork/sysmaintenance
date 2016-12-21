(Note: The following instructions are mostly the same for updating all tables prior to adding the new assembly data. The specific queries for each are just included for maximum clarity.)

The following explains how to update the IndelAll table before adding the new assembly data.

___

1. Add a new column **Mb_start_2016** in the database for the previous assembly versions in the IndelAll table on the server Rabbit. The name for the new column should include the current year (in this case **Mb_start_2016**).

   ```
   ALTER TABLE IndelAll
   ADD COLUMN Mb_start_2016 DOUBLE
   AFTER Mb_start;
  
   ALTER TABLE IndelAll
   ADD COLUMN Mb_end_2016 DOUBLE
   AFTER Mb_end;
   ```

   Each of these queries should last about 7 seconds.

2. The data in **Mb_start** and **Mb_end** should be duplicated in these new colums. The SQL for this is the following:
   ```
   UPDATE IndelAll
   SET
   IndelAll.`Mb_start_2016` = IndelAll.`Mb_start`,
   IndelAll.`Mb_end_2016` = IndelAll.`Mb_end`;
   ```

   This query should take about 1 second.
