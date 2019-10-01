#!/bin/sh

full_name="httpd_apache"
name="httpd"
image="httpd"

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
	-p 80:80 \
	-p 443:443 \
	--name httpd \
	--restart always \
	--net backend \
	-v $PWD/httpd.conf:/usr/local/apache2/conf/httpd.conf \
	-v /mnt/ssl:/usr/local/apache2/conf/ssl \
	-v $PWD/httpd-ssl.conf:/usr/local/apache2/conf/extra/httpd-ssl.conf \
	-d $image

echo $full_name server created, exposing port 80 and 443...


# -e FLOWS=my_flows.json \


