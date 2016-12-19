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
