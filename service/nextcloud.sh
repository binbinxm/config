#!/bin/sh

full_name="nextcloud"
name="nextcloud"
image="nextcloud"

#if [ $# -ne 1 ]; then
#    echo usage: $0 password
#    exit 1
#fi

echo stopping $full_name container...
docker stop $name

echo removing $full_name container...
docker rm $name

#echo downloading latest image from $image...
#docker pull $image

echo starting mysql
docker stop mysql
docker rm mysql
docker run \
	--name=mysql \
	-e MYSQL_ROOT_PASSWORD=PEKtpe8866 \
	--net backend \
	-v /mnt/mysql:/var/lib/mysql \
	--restart always \
	-d mysql:5

echo starting service...
docker run \
-d \
--restart always \
--name $name \
--link mysql:db \
--net backend \
-v /mnt/nextcloud:/var/www/html/ \
-v /mnt/oss/nextcloud:/mnt/oss/ \
$image

echo $full_name server created, monitoring port 80...

