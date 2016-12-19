ALTER TABLE BXDSnpPosition
ADD COLUMN Mb_2016 DOUBLE
AFTER Mb;
# Execution Time : 2 min 15 sec

UPDATE BXDSnpPosition
SET BXDSnpPosition.`Mb_2016` = BXDSnpPosition.`Mb`;
# Execution Time : 49.073 sec
