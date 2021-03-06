#!/usr/bin/env bash
# 在客户端生成 私钥，然后上传到服务器，配置好ssh


"""
On Client ,Exec Command:

```sh
wget https://github.com/MrBenWang/MyWroteScripts/blob/master/vps/public_key_upload_vps.sh -P ~/
chmod a+x public_key_upload_vps.sh
~/public_key_upload_vps.sh [Server IP]
```
"""

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

red="\033[0;31m"
green="\033[0;32m"
plain="\033[0m"

[ -z $1 ] && echo -e "Please input ${red}the parameter(vps ip) ${plain}" && exit 1

# 生成公钥
[ -f ~/.ssh/id_rsa ] && rm -rf ~/.ssh
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ''

# 上传公钥给服务器
ssh-copy-id root@$1 && echo -e "upload id_rsa ${green}success${plain} " || echo -e "upload public_key ${red}failure${plain}"

# ssh-copy-id -p 22 -i ~/.ssh/id_rsa.pub root@123.123.123.123
# scp .ssh/id_rsa.pub username@hostname:~/.ssh/
# vim scp://root@example.com//home/centos/docker-compose.yml
```
Host vps
    HostName 123.123.123.123
    Port 22
    User username
    IndentityFile ~/.ssh/id_rsa
    IdentitiesOnly yes
    LocalForward 5433 localhost:5432   #端口转发
    ProxyCommand ssh gateway netcat -q 600 %h %p      # 代理命令
```