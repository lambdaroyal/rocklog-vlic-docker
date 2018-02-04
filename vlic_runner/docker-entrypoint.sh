#!/bin/bash
set -e

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

function prestart {
  echo "extracting archives"
  tar xf /tmp/vlic/rocklog-vlic.tar.gz

  echo "build ssh keyfiles for ecdsa web tokens"
  mkdir .ssh
  ssh-keygen -q -N "" -t ecdsa -f .ssh/id_ecdsa
}


if [ "$1" = 'bash' ]; then
    echo "start just bash"
    exec bash
fi 

if [ "$1" = '32bit' ]; then
    echo "start rocklog-vlic with without generating demo data in 32bit vm"
    prestart
    java-i586 -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 

if [ "$1" = '64bit' ]; then
    echo "start rocklog-vlic with without generating demo data in 64bit vm"
    prestart
    java -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 

if [ "$1" = '64bit-8g' ]; then
    echo "start rocklog-vlic with without generating demo data in 64bit vm with max heap 8 gigabyte"
    prestart
    java -Duser.timezone=CET -XX:+UseG1GC -Xmx8g -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 
