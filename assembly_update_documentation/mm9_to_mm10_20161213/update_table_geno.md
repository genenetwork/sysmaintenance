1. Geno table on the server Rabbit, add new columns: 
 The names for the new columns should include the current year. For example: 
  - **Mb_2016**
  
  The SQL to do this is the following (though database editing software can be used instead):
  ```
  ALTER TABLE Geno
  ADD COLUMN Mb_2016 DOUBLE
  AFTER Mb;
  ```
   
  These queries should last about 16 sec.

2. Duplicated in these new colums. The SQL for this is the following:
   ```
   UPDATE Geno
   SET Geno.`Mb_2016` = Geno.`Mb`;
   ```

   This query should last about 11 sec.
