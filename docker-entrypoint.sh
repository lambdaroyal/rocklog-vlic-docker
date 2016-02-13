#!/bin/bash
set -e

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

if [ "$1" = 'couchdb' ]; then
    echo "start CouchDB"
    exec "/usr/local/bin/couchdb" > /dev/null &
fi

if [ "$2" = 'bash' ]; then
    echo "start bash"
    exec bash
fi

if [ "$2" = 'medium' ]; then
    echo "start rocklog-vlic with medium dataset"
    cd rocklog-vlic
    java -jar target/rocklog-vlic-0.2-SNAPSHOT-standalone.jar --private-key-file ~/.ssh/id_ecdsa --generate-testdata medium > vlic.log &
    exec bash
fi 

if [ "$2" = 'medium-raw' ]; then
    echo "start rocklog-vlic with medium dataset"
    cd rocklog-vlic
    java -jar target/rocklog-vlic-0.2-SNAPSHOT-standalone.jar --private-key-file ~/.ssh/id_ecdsa > vlic.log &
    exec bash
fi 

if [ "$2" = 'big-raw' ]; then
    echo "start rocklog-vlic with big dataset"
    cd rocklog-vlic
    java -jar target/rocklog-vlic-0.2-SNAPSHOT-standalone.jar --private-key-file ~/.ssh/id_ecdsa --generate-testdata big > vlic.log &
    exec bash
fi 

if [ "$2" = 'demo' ]; then
    echo "start rocklog-vlic with demo dataset"
    cd rocklog-vlic
    java -jar target/rocklog-vlic-0.2-SNAPSHOT-standalone.jar --private-key-file ~/.ssh/id_ecdsa --generate-testdata demo > vlic.log &
    exec bash
fi 
