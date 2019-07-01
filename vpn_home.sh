#!/bin/sh

if [ $# -ne 1 ]; then
    echo "usage: $0 cert_file"
    exit 1
fi
openvpn --config $1 --dev tun
