ALTER TABLE TissueProbeSetXRef
ADD COLUMN Mb_2016 DOUBLE
AFTER Mb;
# Execution Time : 4.069 sec

UPDATE TissueProbeSetXRef
SET
TissueProbeSetXRef.`Mb_2016` = TissueProbeSetXRef.`Mb`;
# Execution Time : 2.075 sec
