/sbin/service httpd stop
rsync -avP rsync://spring211.uthsc.edu/gnsrc/ /gnshare/gn/web/
chown -R apache:apache /gnshare/gn/web
/sbin/service httpd start
