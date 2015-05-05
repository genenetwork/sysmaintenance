/sbin/service mysqld stop
rsync -avP rsync://spring211.uthsc.edu/gndb/ /var/lib/mysql/db_webqtl/
chown -R mysql:mysql /var/lib/mysql/db_webqtl
/sbin/service mysqld start
