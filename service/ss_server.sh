#!/bin/sh

full_name="shadowsocks_server"
name="ss_server"
image="mritd/shadowsocks"

if [ $# -ne 1 ]; then
    echo usage: $0 password
    exit 1
fi

echo stopping $full_name container...
docker stop $name

echo removing $full_name container...
docker rm $name

echo downloading latest image from $image...
docker pull $image

echo starting service...

#customized here

docker run \
-dt \
--restart=always \
--name ss_server \
-p 8364:8364 \
mritd/shadowsocks \
-s "-s 0.0.0.0 -p 8364 -m aes-256-cfb -k $1 --fast-open"

echo $full_name server created, monitoring port 8364...

sleep 3
docker logs $name

