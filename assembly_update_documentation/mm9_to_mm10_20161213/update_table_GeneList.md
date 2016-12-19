The GeneList table is used by GeneNetwork1 (and even GN2) to generated overlays on QTL maps and to generate tables of genes in QTL intervals. The table is was originally populated with mouse data and some associated human and rat data. Maintainng a multipe-species tables is NOT practicaal, and this table should probably be explicitly limited to mouse data (and human or rat homologs).

![table_GeneList_2016-12-19](https://raw.githubusercontent.com/genenetwork/sysmaintenance/master/assembly_update_documentation/mm9_to_mm10_20161213/table_GeneList_2016-12-19.png)


ALTER TABLE GeneList
ADD COLUMN TxStart_2016 DOUBLE
AFTER TxStart;
# Execution Time : 3.034 sec

ALTER TABLE GeneList
ADD COLUMN TxEnd_2016 DOUBLE
AFTER TxEnd;
# Execution Time : 3.094 sec

UPDATE GeneList
SET
GeneList.`TxStart_2016`	= GeneList.`TxStart`,
GeneList.`TxEnd_2016`	= GeneList.`TxEnd`;
# Execution Time : 2.078 sec
