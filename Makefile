current_dir := $(shell pwd)

ifndef VLIC_PORT
	VLIC_PORT := 8080
endif

ifndef COUCHDB_PORT 
	COUCHDB_PORT := 5984
endif

ifndef CONT_NAME
	CONT_NAME := $(shell date +%s | sha256sum | base64 | head -c 32)
endif

clone:
	mkdir -p .ssh
	cp ~/.ssh/id_rsa* ./.ssh 
	chmod +rx docker-entrypoint.sh
	rm -r -f rocklog-vlic
	git clone git@github.com:lambdaroyal/rocklog-vlic.git -b $(branch)
	-mkdir rocklog-vlic/resources/geolite2
	-curl http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz > rocklog-vlic/resources/geolite2/GeoLite2-City.mmdb.gz
	-gzip -d rocklog-vlic/resources/geolite2/GeoLite2-City.mmdb.gz

update:
	echo "Update VLIC from gtihub repo"
	(cd rocklog-vlic && git fetch && git pull)

build-vlic:
	(cd rocklog-vlic && lein clean && lein javac && lein uberjar)

build:
	sudo docker build -t vlic/vlic_runner:v1 .

bash:
	sudo docker run -t -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -it vlic/vlic_runner:v1 couchdb bash

medium:
	sudo docker run -d -t -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -it vlic/vlic_runner:v1 couchdb medium

medium-raw:
	sudo docker run -d -t -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -it vlic/vlic_runner:v1 couchdb medium-raw

medium-persistent:
	echo "Building medium size container with unique data dir $(CONT_NAME)"
	-mkdir $(CONT_NAME)
	-mkdir $(CONT_NAME)/data
	-mkdir $(CONT_NAME)/tmp
	-mkdir $(CONT_NAME)/log
	sudo docker run -d -t -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -it vlic/vlic_runner:v1 couchdb medium-raw

big-persistent:
	echo "Building big size container with unique data dir $(CONT_NAME)"
	-mkdir $(CONT_NAME)
	-mkdir $(CONT_NAME)/data
	-mkdir $(CONT_NAME)/tmp
	-mkdir $(CONT_NAME)/log
	sudo docker run -d -t -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -it vlic/vlic_runner:v1 couchdb big-raw


demo:
	echo "Building demo container with unique data dir $(CONT_NAME)"
	-mkdir $(CONT_NAME)
	-mkdir $(CONT_NAME)/data
	-mkdir $(CONT_NAME)/tmp
	-mkdir $(CONT_NAME)/log
	sudo docker run -d -t -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -it vlic/vlic_runner:v1 couchdb demo
