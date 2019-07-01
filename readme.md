# introduction
Here's all the configurations of my ali server.

# topology

```
                              +---------------------+
                              |      wc_period      |
                              +---------------------+
                                ^
                                |
                                |
+-----------------------+     +---------------------+     +-----------+
| listening on port 443 | --> |        nginx        | --> | mynodered |
+-----------------------+     |                     |     +-----------+
+-----------------------+     |    reverse proxy &  |     +-----------+
|        wc_chat        | <-- |    https offload    | --> | notebook  |
+-----------------------+     +---------------------+     +-----------+
                                |
                                |
                                v
                              +---------------------+
                              | restheart-dev-mongo |
                              +---------------------+
```

# env configuration

swap.sh - create 4GB swap file

tmux.sh - setup my tmux environment

vim.sh - setup my vim environment

vpn_home.sh - openVPN client connecting to home network, **password** in Evernote

# nginx backend server configuration

wc_chat
```
description: my wechat robot
mapping: https://binya.me/wc_chat -> http://wc_chat/
docker image: binbinxm/conda:base
script: service/run_web.sh wc_chat
network: web_backend
expose: none
mount: /mnt/wc_chat
```

wc_period
```
description: my wechat robot
mapping: https://binya.me/wc_period -> http://wc_period/
docker image: binbinxm/conda:base
script: service/run_web.sh wc_chat
network: web_backend
expose: none
mount: /mnt/wc_period
```

notebook
```
description: my Jupyter notebook
mapping: https://nb.binya.me -> http://notebook:8844/
docker image: binbinxm/conda:base
script: service/jupyter.sh
network: web_backend
expose: 8844/tcp(internal)
mount: /mnt/notebook
password: Evernote
```

mynodered
```
description: my node-red server
maping: https://iot.binya.me -> http://mynodered:1880
docker image: nodered/node-red-docker
script: service/nodered.sh
network: web_backend
expose: 1880/tcp(internal)
mount: /mnt/nodered
```

restheart-dev-mongo
```
description: my mongodb server
mapping: na
docker image: mongo:3.4
script: service/mongo/docker-compose up -d
network: web_backend
expose: 27017/tcp(internal)
mount: /mnt/db/mongo/
```

# nginx service

configuration
```
docker image: nginx
script: service/nginx/nginx.sh
network: web_backend
expose: 443/tcp(**external**)
mount: /mnt/ssl(SSL keys)
```

# obsoleted functions

restheart - mongodb API, replaced by node-red.

thingsboard - iot device management system, obsoleted, some of the functions are replaced by node-red.
