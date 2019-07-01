#!/bin/sh

full_name="thingsboard"
name="thingsboard"
image="binbinxm/thingsboard:base"

#if [ $# -ne 1 ]; then
#    echo usage: $0 password
#    exit 1
#fi

echo stopping $full_name container...
docker stop $name

echo removing $full_name container...
docker rm $name

echo downloading latest image from $image...
docker pull $image

echo starting service...
docker run \
-it \
--name $name \
--restart always \
--net web_backend \
-v /mnt/tb/hsqldb_volume:/usr/share/thingsboard/data/sql \
-v /mnt/tb:/mnt \
-p 1883:1883 \
-p 8080:8080 \
$image \
bash -c "service thingsboard start&&sleep 5&&tail -f /var/log/thingsboard/thingsboard.log"

echo $full_name server created, exposing port 8080 and 1883...

