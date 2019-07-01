#!/bin/sh

if [ $# -ne 2 ]; then
    echo usage: $0 password
    exit 1
fi

full_name="web_backend: $1"
name=$1
image=binbinxm/conda:base

echo stopping $full_name container...
docker stop $name

echo removing $full_name container...
docker rm $name

echo downloading latest image from $image...
docker pull $image

echo 'starting service...'
#docker run -it -v /mnt/$name:/mnt --name=$name --net=web_backend $image -c '/mnt/main.py'
docker run -it -v /mnt/$name:/mnt --name=$name --net=web_backend $image

echo $full_name server created, monitoring port 80...

