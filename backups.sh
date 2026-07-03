#!/bin/bash
#Run this entyre script with sudo

#archive and backuping files
bak_date="20260705" #change date here and it will automaticaly add to the backup file name
path_to_goal="/home/***/ishemgulovaea"

tar -czvf $path_to_goal/backup_test/bash_backup_$bak_date.tar.gz  \
$path_to_goal/Документы/bash_practice


sudo useradd -m -s /bin/bash jjoe #add user with home directory and shell
echo "jjoe:12345678" | chpasswd

setfacl -R -m u:jjoe:rx $path_to_goal/Документы/bash_practice #права на чтение исходной папки с  тем, что нужно забэкапить
setfacl -R -m u:jjoe:rwx $path_to_goal/backup_test #права на создание новых бэкапов в директории с ними
setfacl -R -m u:jjoe:x $path_to_goal #выдача прав на корневую папку где лежат все остальные

#cron configure
cd /etc/cron.d/
echo "0 * * * * jjoe /home/***/ishemgulovaea/basic_skills/backups.sh" >> backup