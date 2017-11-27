stamp=$(date +"%d")
rsync -avP --delete rsync://lily.uthsc.edu/gnsrc/	/mnt/sdd1/backup/gn/gnsrc/$stamp/
rsync -avP --delete rsync://lily.uthsc.edu/gndb/	/mnt/sdd1/backup/gn/gndb/$stamp/
