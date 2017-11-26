rsync -avP --delete -e "ssh -i /home/leiyan/awskey/lyan6/leiyan.pem" root@107.21.107.47:/var/lib/mysql/db_webqtl/ /var/lib/mysql/db_webqtl/
chown -R mysql:mysql /var/lib/mysql/db_webqtl
