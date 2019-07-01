#!/bin/sh

full_name="developping_environment"
name="dev"
image="binbinxm/conda:base"

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

#customized here

docker run \
-it \
--name $name \
-v /mnt:/mnt \
$image

echo $full_name server created

