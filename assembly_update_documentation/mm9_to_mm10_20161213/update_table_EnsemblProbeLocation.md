ALTER TABLE EnsemblProbeLocation 
ADD COLUMN Start_2016 INT(11)
AFTER START;
# Execution Time : 12.019 sec

ALTER TABLE EnsemblProbeLocation 
ADD COLUMN End_2016 INT(11)
AFTER END;
# Execution Time : 12.006 sec

UPDATE EnsemblProbeLocation
SET
EnsemblProbeLocation.`Start_2016`	= EnsemblProbeLocation.`Start`,
EnsemblProbeLocation.`End_2016`		= EnsemblProbeLocation.`End`;
# Execution Time : 19.035 sec
