ALTER TABLE IndelAll
ADD COLUMN Mb_start_2016 DOUBLE
AFTER Mb_start;

# Execution Time : 7.022 sec

ALTER TABLE IndelAll
ADD COLUMN Mb_end_2016 DOUBLE
AFTER Mb_end;

# Execution Time : 7.099 sec

UPDATE IndelAll
SET
IndelAll.`Mb_start_2016` = IndelAll.`Mb_start`,
IndelAll.`Mb_end_2016` = IndelAll.`Mb_end`;

# Execution Time : 1.099 sec
