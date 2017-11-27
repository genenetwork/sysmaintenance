stamp=$(date +"%d")
stamp=$(($stamp % 7))
rsync -avP --delete rsync://files.genenetwork.org/gnfiles/	/mnt/sdd1/backup/gn/gnfile/$stamp/
