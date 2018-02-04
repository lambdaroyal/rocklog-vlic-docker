#!/bin/bash
set -e

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

# Prestart CouchDB
if [ "$1" = 'couchdb']; then
	# we need to set the permissions here because docker mounts volumes as root
	chown -R couchdb:couchdb /opt/couchdb

	chmod -R 0770 /data

	chmod 664 /opt/couchdb/etc/*.ini
	chmod 664 /opt/couchdb/etc/local.d/*.ini
	chmod 775 /opt/couchdb/etc/*.d

	if [ ! -z "$NODENAME" ] && ! grep "couchdb@" /opt/couchdb/etc/vm.args; then
		echo "-name couchdb@$NODENAME" >> /opt/couchdb/etc/vm.args
	fi

	if [ "$COUCHDB_USER" ] && [ "$COUCHDB_PASSWORD" ]; then
		# Create admin
		printf "[admins]\n%s = %s\n" "$COUCHDB_USER" "$COUCHDB_PASSWORD" > /opt/couchdb/etc/local.d/docker.ini
		chown couchdb:couchdb /opt/couchdb/etc/local.d/docker.ini
	fi

	if [ "$COUCHDB_SECRET" ]; then
		# Set secret
		printf "[couch_httpd_auth]\nsecret = %s\n" "$COUCHDB_SECRET" >> /opt/couchdb/etc/local.d/docker.ini
		chown couchdb:couchdb /opt/couchdb/etc/local.d/docker.ini
	fi

	# if we don't find an [admins] section followed by a non-comment, display a warning
	if ! grep -Pzoqr '\[admins\]\n[^;]\w+' /opt/couchdb/etc/local.d/*.ini; then
		# The - option suppresses leading tabs but *not* spaces. :)
		cat >&2 <<-'EOWARN'
			****************************************************
			WARNING: CouchDB is running in Admin Party mode.
			         This will allow anyone with access to the
			         CouchDB port to access your database. In
			         Docker's default configuration, this is
			         effectively any other container on the same
			         system.
			         Use "-e COUCHDB_USER=admin -e COUCHDB_PASSWORD=password"
			         to set it in "docker run".
			****************************************************
		EOWARN
	fi


	exec gosu couchdb "$@"
fi

function prestart {
  echo "extracting archives"
  tar xf /tmp/vlic/rocklog-vlic.tar.gz

  echo "build ssh keyfiles for ecdsa web tokens"
  mkdir .ssh
  ssh-keygen -q -N "" -t ecdsa -f .ssh/id_ecdsa
}


if [ "$2" = 'bash' ]; then
    echo "start just bash"
    exec bash
fi 

if [ "$2" = '32bit' ]; then
    echo "start rocklog-vlic with without generating demo data in 32bit vm"
    prestart
    java-i586 -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 

if [ "$2" = '64bit' ]; then
    echo "start rocklog-vlic with without generating demo data in 64bit vm"
    prestart
    java -Duser.timezone=CET -XX:+UseG1GC -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 

if [ "$2" = '64bit-8g' ]; then
    echo "start rocklog-vlic with without generating demo data in 64bit vm with max heap 8 gigabyte"
    prestart
    java -Duser.timezone=CET -XX:+UseG1GC -Xmx8g -XX:+UseStringDeduplication -jar target/rocklog-vlic-standalone.jar --private-key-file .ssh/id_ecdsa
fi 
