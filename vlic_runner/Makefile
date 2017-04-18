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

persist:
	-mkdir $(CONT_NAME)
	-mkdir $(CONT_NAME)/data
	-mkdir $(CONT_NAME)/tmp
	-mkdir $(CONT_NAME)/tmp/vlic

bash:
	echo "Starting bash in new container"
	sudo docker run --name=$(CONT_NAME) -it --restart='always' -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro -it vlic/vlic_runner:v1 bash

extract: persist
	-cp $(ARCHIVE) $(CONT_NAME)/tmp/vlic/rocklog-vlic.tar.gz


demo: extract
	echo "Building demo container with unique data dir $(CONT_NAME) with archive $(ARCHIVE)"
	-mkdir $(CONT_NAME)/log
	sudo docker run --name=$(CONT_NAME) -dt --restart='always' -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro -it vlic/vlic_runner:v1 demo

demo32bit: extract
	echo "Building demo container with unique data dir $(CONT_NAME) with archive $(ARCHIVE)"
	-mkdir $(CONT_NAME)/log
	sudo docker run --name=$(CONT_NAME) -dt --restart='always' -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro -it vlic/vlic_runner:v1 demo32bit

big: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE)"
	-mkdir $(CONT_NAME)/log
	sudo docker run --name=$(CONT_NAME) -dt --restart='always' -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro -it vlic/vlic_runner:v1 big

big32bit: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE)"
	-mkdir $(CONT_NAME)/log
	sudo docker run --name=$(CONT_NAME) -dt --restart='always' -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro -it vlic/vlic_runner:v1 big32bit

medium-raw: extract
	echo "Building medium container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	sudo docker run --name=$(CONT_NAME) -dt --restart='always' -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro -it vlic/vlic_runner:v1 medium-raw

medium-raw-32bit: extract
	echo "Building medium container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	sudo docker run --name=$(CONT_NAME) -dt --restart='always' -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro -it vlic/vlic_runner:v1 medium-raw-32bit

medium-raw-32bit-just-daemon: extract
	echo "Building medium container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker run --rm --name=$(CONT_NAME) -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none vlic/vlic_runner:v1 medium-raw-32bit-just-daemon
