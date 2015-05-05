GNRoot="/gnshare/gn"
find $GNRoot/web/tmp/	-mtime +1 -exec rm -rfv {} \;
find $GNRoot/web/image/	-mtime +1 -exec rm -rfv {} \;
mkdir $GNRoot/web/tmp
mkdir $GNRoot/web/image
chown -R apache:apache $GNRoot
