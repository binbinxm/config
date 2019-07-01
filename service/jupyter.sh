#!/bin/sh

full_name="jupyter_notebook"
name="notebook"
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
docker run \
-dt \
--restart always \
--name $name \
--net web_backend \
-v /mnt/notebook:/mnt \
$image \
-c "jupyter notebook --notebook-dir=/mnt \
--ip='*' \
--NotebookApp.password='sha1:52cd1c27f679:e7462eee42905d2b55ed2308fd4a3cd9acc75be4' \
--port=8844 \
--allow-root \
--no-browser"

#-v /mnt/notenook/ssl:/mnt/ssl \

#--NotebookApp.keyfile='/mnt/ssl/privkey.pem' \
#--NotebookApp.certfile='/mnt/ssl/fullchain.pem' \

echo $full_name server created, monitoring port 8844...

