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

Geno table also was updated to mm10

mysql> desc Geno;
+-------------------+----------------------+------+-----+---------+----------------+
| Field             | Type                 | Null | Key | Default | Extra          |
+-------------------+----------------------+------+-----+---------+----------------+
| Id                | int(10) unsigned     | NO   | PRI | NULL    | auto_increment |
| SpeciesId         | smallint(5) unsigned | NO   | MUL | 1       |                |
| Name              | varchar(40)          | NO   |     |         |                |
| Marker_Name       | varchar(40)          | YES  |     | NULL    |                |
| Chr               | char(3)              | YES  |     | NULL    |                |
| Mb                | double               | YES  |     | NULL    |                |
| Sequence          | text                 | YES  |     | NULL    |                |
| Source            | varchar(40)          | YES  |     | NULL    |                |
| chr_num           | smallint(5) unsigned | YES  |     | NULL    |                |
| Source2           | varchar(40)          | YES  |     | NULL    |                |
| Comments          | varchar(255)         | YES  |     | NULL    |                |
| used_by_geno_file | varchar(40)          | YES  |     | NULL    |                |
| Mb_mm8            | double               | YES  |     | NULL    |                |
| Chr_mm8           | char(3)              | YES  |     | NULL    |                |
+-------------------+----------------------+------+-----+---------+----------------+
14 rows in set (0.00 sec)

However this table has total 483027 records and only 35061 belongs to SpeciesId=1 (Mouse)

mysql> select max(Id) from Geno;
+---------+
| max(Id) |
+---------+
|  483027 |
+---------+
1 row in set (0.01 sec)

mysql> select Id, Marker_Name, Chr, Mb from Geno where SpeciesId=1 order by Id ASC INTO OUTFILE '/tmp/Geno_Table_mm9.txt' FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';
Query OK, 35061 rows affected (0.29 sec)

STEP 3. Convert the Mb values to base pair 
awk '{ OFS = "\t" ; printf ("%.10g\n", $2*1000000)}' Geno_Table_mm9.txt > Geno_Table_Mb_mm9.txt

STEP 4. I prepared a BED file (Geno_Table_Mb_mm9.bed) with the chromosome, start, end, Id (Id column is important to keep track of the position since genome liftover delete the row not found. 
Run the liftover. Using Lift genome annotations at
http://genome.ucsc.edu/cgi-bin/hgLiftOver

STEP 5.
mysql> LOAD DATA INFILE '/home/acenteno/liftover_mm9-mm10/Geno_Table_Id_Mb_mm10.txt' INTO TABLE Vlookup (Id, Mb);
Query OK, 35054 rows affected (0.18 sec)
Records: 35054  Deleted: 0  Skipped: 0  Warnings: 0

mysql> select Id, Mb from Vlookup limit 10;
+----+------------+
| Id | Mb         |
+----+------------+
|  1 |   4.688207 |
|  2 |   6.469816 |
|  8 |  38.996112 |
|  9 |  44.213881 |
| 10 |  49.302433 |
| 12 |  54.095723 |
| 13 |  61.839045 |
| 17 |  72.877041 |
| 21 |  93.622085 |
| 25 | 107.517268 |
+----+------------+
10 rows in set (0.00 sec)

STEP 6. Then replace the old Mb values (mm9) with the new ones (mm10)

mysql> UPDATE Geno p1, Vlookup p2
    -> SET p1.Mb = p2.Mb
    -> WHERE p1.Id = p2.Id;
Query OK, 34376 rows affected (0.85 sec)
Rows matched: 35054  Changed: 34376  Warnings: 0

STEP 7. Por testing purposes I re-run QTL reaper for dataset GN112 "BXD Hippocampus Consortium M430v2 (Jun06) PDNN" using the python script

python QTL_Reaper_v6.py 112

lrs=(40 2000) 2634 records

It works!
