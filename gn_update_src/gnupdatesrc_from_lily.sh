/sbin/service httpd stop
rsync -avP --delete rsync://lily.uthsc.edu/gnsrc/ /gnshare/gn/web/
chown -R apache:apache /gnshare/gn/web
/sbin/service httpd start
