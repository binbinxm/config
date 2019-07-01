#!/bin/sh

full_name="nginx_server"
name="nginx"
image="nginx"

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

echo starting service...
docker run \
--name $name \
--restart unless-stopped \
--net web_backend \
-p 443:443 \
-v $PWD/nginx.conf:/etc/nginx/nginx.conf:ro \
-v /mnt/ssl:/mnt/ssl:ro \
-d nginx

echo $full_name server created, monitoring port 443...

sleep 3
docker logs $name

