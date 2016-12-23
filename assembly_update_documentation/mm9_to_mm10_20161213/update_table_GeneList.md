(Note: The following instructions are mostly the same for updating all tables prior to adding the new assembly data. The specific queries for each are just included for maximum clarity.)

The GeneList table is used by GeneNetwork1 (and even GN2) to generated overlays on QTL maps and to generate tables of genes in QTL intervals. The table is was originally populated with mouse data and some associated human and rat data. Maintaining a multiple-species table is NOT practical, and this table should probably be explicitly limited to mouse data (and human or rat homologs).

![table_GeneList_2016-12-19](https://raw.githubusercontent.com/genenetwork/sysmaintenance/master/assembly_update_documentation/mm9_to_mm10_20161213/table_GeneList_2016-12-19.png)

The following explains how to update the GeneList table before adding the new assembly data.

___


1. Add new columns **TxStart_2016** and **TxEnd_2016** in the database for the previous assembly versions in the GeneList table on the server Rabbit. The names for the new columns should include the current year (in this case **TxStart_2016** and **TxEnd_2016**).
   ```
   ALTER TABLE GeneList
   ADD COLUMN TxStart_2016 DOUBLE
   AFTER TxStart;
   
   ALTER TABLE GeneList
   ADD COLUMN TxEnd_2016 DOUBLE
   AFTER TxEnd;
   ```
   
   Each of these queries should last around 3 seconds.
   
2. The data in **TxStart** and **TxEnd** should be duplicated in these new colums. The SQL for this is the following:
   ```
   UPDATE GeneList
   SET
   GeneList.`TxStart_2016`	= GeneList.`TxStart`,
   GeneList.`TxEnd_2016`	= GeneList.`TxEnd`;
   ```
   
   This query should last around 2 seconds.
