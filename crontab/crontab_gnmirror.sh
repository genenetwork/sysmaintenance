sh /home/leiyan/sysmaintenance/update_sysmaintenance/update_from_spring211.sh	1>/home/leiyan/sysmaintenance/update_sysmaintenance/update_from_spring211.log	2>&1
sh /home/leiyan/sysmaintenance/ntpdate/ntpdate.sh				1>/home/leiyan/sysmaintenance/ntpdate/ntpdate.log				2>&1
sh /home/leiyan/sysmaintenance/gn_update_db/gnupdatedb_from_spring211.sh	1>/home/leiyan/sysmaintenance/gn_update_db/gnupdatedb_from_spring211.log	2>&1
sh /home/leiyan/sysmaintenance/gn_update_src/gnupdatesrc_from_spring211.sh	1>/home/leiyan/sysmaintenance/gn_update_src/gnupdatesrc_from_spring211.log	2>&1
sh /home/leiyan/sysmaintenance/gn_deletetemp/deletetemp.sh			1>/home/leiyan/sysmaintenance/gn_deletetemp/deletetemp.log			2>&1
