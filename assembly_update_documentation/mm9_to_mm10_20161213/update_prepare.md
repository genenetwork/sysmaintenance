We periodically need to update genome assemblies used by GeneNetwork 1 and 2. This file details the process used to update the database tables accordingly. This file was prepared as part of the LiftOver from mm9 to mm10 (also know as GRCm38) in December 2016 done by Lei Yan, Arthur Centeno, and Zach Sloan. We also need to update rat (rn3 to rn6) and human (hg19 to hg38) genomes, but the text below is directly relevant to mouse. For the most part, the process would be the same for other species, only with the SpeciesId in the queries changed to the Id corresponding with the desired species.

Below starting the update, we need to create a new archive using Time Machine and synchronize the test server's (Rabbit) database and code with the production server (Lily). 

- Create new GN1 archive (2016-12-12) using Time Machine: http://artemis-20161212.genenetwork.org/

   Past archives can be accessed through http://artemis.uthsc.edu/

- Synchronize the server Rabbit's database and code with Lily's. The following scripts are used to do this:
   * Source code sync script - [GitHub](https://github.com/genenetwork/sysmaintenance/blob/master/gn_update_src/gnupdatesrc_from_lily.sh)
   * Database sync script - [GitHub](https://github.com/genenetwork/sysmaintenance/blob/master/gn_update_db/gnupdatedb_from_lily.sh)

update tables:

BXDSnpPosition
EnsemblProbeLocation
GeneList_rn3
GeneList_rn33
Geno
IndelAll
ProbeSet
SnpAll
TissueProbeSetXRef

update files:
BXD.geno
