#!/bin/sh

full_name="mynodered"
name="mynodered"
image="nodered/node-red-docker"

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
-dt \
-p 1883:1883 \
--name $name \
--restart always \
--net web_backend \
-v /mnt/nodered:/data \
$image

echo $full_name server created, exposing port 1883...


# -e FLOWS=my_flows.json \


