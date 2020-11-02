#!/bin/bash

DATABASENAME=$(cat ../docker-compose.yml | grep 'MYSQL_DATABASE:' | awk -F " " '{print $2}')
USERNAME=$(cat ../docker-compose.yml | grep 'MYSQL_USER:' | awk -F " " '{print $2}')
USERPASS=$(cat ../docker-compose.yml | grep 'MYSQL_PASSWORD:' | awk -F " " '{print $2}')
MYSQLHOST=$(cat ../docker-compose.yml | grep 'DB_HOST:' | awk -F " " '{print $2}')
SITENAME=$(pwd | awk -F "/" '{print $5}')

mkdir -p ./backups

tar -cvf ./backups/htdocs-$(date +%Y-%m-%d_%H:%M:%S).tar.gz ./wp2.local
docker exec -ti $MYSQLHOST mysqldump -u$USERNAME -p$USERPASS $DATABASENAME > ./backups/$SITENAME-$(date +%Y-%m-%d_%H:%M:%S).sql


# delete backups with 14 files saved with the latest changes
pushd ./backups
SaveFilesCount=14 # минимальное количество файлов, которое должно остаться.
AllFilesCount=`ls |wc -l` # общее количество файлов в директории.
if [ $AllFilesCount -gt $SaveFilesCount ]; then # условие - если общее количество файлов больше чем минимальное то
let "RmFilesCount = $AllFilesCount - $SaveFilesCount" # вычисление количества удаляемых файлов.
rm -f `ls -t |tail -$RmFilesCount` # собственно, получение RmFilesCount последних элементов, сортированного по дате модификации, в порядке более старые в конце, списка файлов в директории и их удаление.
fi
popd

unset DATABASENAME
unset USERNAME
unset USERPASS
unset MYSQLHOST
unset SITENAME