#!/bin/bash
set -e

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

_uname=$1
_uid=$2
echo "Create user $_uname with id $_uid"
useradd -m -d /var/buildbot -u $_uid $_uname
echo $_uname:admin | chpasswd
adduser $_uname sudo
chown $_uname /var/buildbot
chown $_uname /var/buildbot/repository

chsh -s /bin/bash $_uname

/usr/bin/supervisord -n

