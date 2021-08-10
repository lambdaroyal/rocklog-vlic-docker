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

if [ "$1" = 'bash' ]; then
  echo "start bash"
  bash
fi

if [ "$1" = '64bit' ]; then
    echo "start rocklog-vlic with without generating demo data in 64bit vm - headless true"
    prestart
    java -Dmongodb_username=${MONGODB_USERNAME} -Dmongodb_password=${MONGODB_PASSWORD} -Dmongodb_posturl=${MONGODB_POSTURL} -Dmongodb_preurl=${MONGODB_PREURL} -Dmongodb_dbname=${MONGODB_DBNAME} -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2,SSLv3" -Djava.awt.headless=true -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 

if [ "$1" = '64bit-2g' ]; then
    echo "start rocklog-vlic with without generating demo data in 64bit vm - headless true"
    prestart
    java -Dmongodb_username=${MONGODB_USERNAME} -Dmongodb_password=${MONGODB_PASSWORD} -Dmongodb_posturl=${MONGODB_POSTURL} -Dmongodb_preurl=${MONGODB_PREURL} -Dmongodb_dbname=${MONGODB_DBNAME} -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2,SSLv3" -Djava.awt.headless=true -Duser.timezone=CET -XX:+UseG1GC -Xmx2g -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 

if [ "$1" = '64bit-3g' ]; then
    echo "start rocklog-vlic with without generating demo data in 64bit vm - headless true max RAM 3gb"
    prestart
    java -Dmongodb_username=${MONGODB_USERNAME} -Dmongodb_password=${MONGODB_PASSWORD} -Dmongodb_posturl=${MONGODB_POSTURL} -Dmongodb_preurl=${MONGODB_PREURL} -Dmongodb_dbname=${MONGODB_DBNAME} -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2,SSLv3" -Djava.awt.headless=true -Duser.timezone=CET -XX:+UseG1GC -Xmx3g -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa --evictor-type mongodb
fi 

if [ "$1" = '64bit-4g' ]; then
    echo "start rocklog-vlic with without generating demo data in 64bit vm - headless true"
    prestart
    java -Dmongodb_username="$MONGODB_USERNAME" -Dmongodb_password="$MONGODB_PASSWORD" -Dmongodb_posturl="$MONGODB_POSTURL" -Dmongodb_preurl="$MONGODB_PREURL" -Dmongodb_dbname="$MONGODB_DBNAME" -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2,SSLv3" -Djava.awt.headless=true -Duser.timezone=CET -XX:+UseG1GC -Xmx4g -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 


if [ "$1" = '64bit-8g' ]; then
    echo "start rocklog-vlic with without generating demo data in 64bit vm with max heap 8 gigabyte - headless true"
    prestart
    java -Dmongodb_username=${MONGODB_USERNAME} -Dmongodb_password=${MONGODB_PASSWORD} -Dmongodb_posturl=${MONGODB_POSTURL} -Dmongodb_preurl=${MONGODB_PREURL} -Dmongodb_dbname=${MONGODB_DBNAME} -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2,SSLv3" -Djava.awt.headless=true -Duser.timezone=CET -XX:+UseG1GC -Xmx8g -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 
