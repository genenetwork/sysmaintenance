GNRoot="/gnshare/gn"
find $GNRoot/web/tmp/	-mmin +600 -exec rm -rfv {} \;
find $GNRoot/web/image/	-mmin +600 -exec rm -rfv {} \;
mkdir $GNRoot/web/tmp
mkdir $GNRoot/web/image
chown -R apache:apache $GNRoot
