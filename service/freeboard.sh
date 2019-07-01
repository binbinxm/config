#!/bin/sh

full_name="freeboard"
name="freeboard"
image="linarotechnologies/freeboard"

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
-p 80:80 \
-dt \
-v /mnt/freeboard/nginx/default.conf.public:/etc/nginx/conf.d/default.conf \
-v /mnt/freeboard/nginx/htpasswd:/etc/nginx/htpasswd \
-v /mnt/freeboard/source:/usr/share/nginx/html \
-v /mnt/freeboard/index.html:/usr/share/nginx/html/index.html \
-v /mnt/freeboard/plugin_custom:/usr/share/nginx/html/plugins/plugin_custom \
-v /mnt/freeboard/json:/usr/share/nginx/html/json \
--name freeboard \
--restart always \
$image

echo $full_name server created, exposing port 80...
