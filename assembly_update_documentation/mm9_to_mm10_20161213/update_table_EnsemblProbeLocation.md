(Note: The following instructions are mostly the same for updating all tables prior to adding the new assembly data. The specific queries for each are just included for maximum clarity.)

The following explains how to update the EnsemblProbeLocation table before adding the new assembly data.

___

1. Add new columns **Start_2016** and **End_2016** in the database for the previous assembly versions in the EnsemblrProbeLocation table on the server Rabbit. The name for these new columns should include the current year (in this case **Start_2016** and **End_2016**). 
   ```
   ALTER TABLE EnsemblProbeLocation 
   ADD COLUMN Start_2016 INT(11)
   AFTER START;

   ALTER TABLE EnsemblProbeLocation 
   ADD COLUMN End_2016 INT(11)
   AFTER END;
   ```
   
   Each of these queries should take around 12 seconds.
   
2. The data in Start and End should be duplicated in these new colums. The SQL for this is the following:
   ```
   UPDATE EnsemblProbeLocation
   SET
   EnsemblProbeLocation.`Start_2016`	= EnsemblProbeLocation.`Start`,
   EnsemblProbeLocation.`End_2016`		= EnsemblProbeLocation.`End`;
   ```
   
   This query should take around 19 seconds.
