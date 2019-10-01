#!/bin/sh

full_name="nodered"
name="nodered"
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
--name $name \
-p 1883:1883 \
--restart always \
--net backend \
-v /mnt/nodered:/data \
$image

echo $full_name server created, exposing port 1883...


# -e FLOWS=my_flows.json \
