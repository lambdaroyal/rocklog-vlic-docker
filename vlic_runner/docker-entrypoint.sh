#!/bin/bash
set -e

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

echo "start CouchDB"
exec "/usr/local/bin/couchdb" > /dev/null &

echo "extracting archives"
tar xf /tmp/vlic/rocklog-vlic.tar.gz

echo "build ssh keyfiles for ecdsa web tokens"
mkdir .ssh
ssh-keygen -q -N "" -t ecdsa -f .ssh/id_ecdsa

if [ "$1" = 'bash' ]; then
    echo "start just bash"
    echo "try: java-i586 -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa --generate-testdata demo"
    exec bash
fi 

if [ "$1" = 'demo' ]; then
    echo "start rocklog-vlic with demo dataset"
    java -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa --generate-testdata demo &
    exec bash
fi 

if [ "$1" = 'demo32bit' ]; then
    echo "start rocklog-vlic with demo dataset in 32bit vm"
    java-i586 -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa --generate-testdata demo &
    exec bash
fi 

if [ "$1" = 'big' ]; then
    echo "start rocklog-vlic with big dataset"
    java -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa --generate-testdata big &
    exec bash
fi 

if [ "$1" = 'big32bit' ]; then
    echo "start rocklog-vlic with big dataset in 32bit vm"
    java-i586 -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa --generate-testdata big &
    exec bash
fi 

if [ "$1" = 'medium-raw' ]; then
    echo "start rocklog-vlic with medium numberrange set without generating demo data"
    java -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa &
    exec bash
fi 

if [ "$1" = 'medium-raw-32bit' ]; then
    echo "start rocklog-vlic with medium numberrange set without generating demo data in 32bit vm"
    java-i586 -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa &
    exec bash
fi 

if [ "$1" = 'medium-raw-32bit-just-daemon' ]; then
    echo "start rocklog-vlic with medium numberrange set without generating demo data in 32bit vm"
    java-i586 -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 
