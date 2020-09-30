#!/bin/bash
set -e

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

function prestart {
  echo "extracting archives"
  tar xf /tmp/vlic/rocklog-vlic.tar.gz

  echo "build ssh keyfiles for ecdsa web tokens"
  mkdir -p .ssh
  if [ -f .ssh/id_ecdsa ]
  then
    echo "id_ecdsa" exists
  else
    ssh-keygen -q -N "" -t ecdsa -f .ssh/id_ecdsa
  fi
}

echo "$1" 
echo "$2"

# Prestart CouchDB
if [ "$1" = 'couchdb' ]; then
  echo "start CouchDB"
  exec "/usr/local/bin/couchdb" > /dev/null &
fi

if [ "$2" = 'bash' ]; then
  echo "start bash"
  bash
fi


if [ "$2" = '32bit' ]; then
    echo "start rocklog-vlic with without generating demo data in 32bit vm - headless true"
    prestart
    java-i586 -Djdk.tls.client.protocols="TLSv1.2,SSLv3" -Djava.awt.headless=true -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 

if [ "$2" = '64bit' ]; then
    echo "start rocklog-vlic with without generating demo data in 64bit vm - headless true"
    prestart
    java -Djdk.tls.client.protocols="TLSv1.2,SSLv3" -Djdk.tls.client.protocols="TLSv1.2,SSLv3" -Djava.awt.headless=true -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 

if [ "$2" = '64bit-8g' ]; then
    echo "start rocklog-vlic with without generating demo data in 64bit vm with max heap 8 gigabyte - headless true"
    prestart
    java -Djdk.tls.client.protocols="TLSv1.2,SSLv3" -Djava.awt.headless=true -Duser.timezone=CET -XX:+UseG1GC -Xmx8g -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 
