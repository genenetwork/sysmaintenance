GNRoot="/gnshare/gn"
find $GNRoot/web/tmp	-mmin +100 -exec rm -rfv {} \;
find $GNRoot/web/image	-mmin +100 -exec rm -rfv {} \;
mkdir -p $GNRoot/web/tmp
mkdir -p $GNRoot/web/image
chown -R apache:apache $GNRoot
