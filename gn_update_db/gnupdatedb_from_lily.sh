/sbin/service mysqld stop
rsync -avP rsync://lily.uthsc.edu/gndb/ /var/lib/mysql/db_webqtl/
chown -R mysql:mysql /var/lib/mysql/db_webqtl
/sbin/service mysqld start
