VERSION := v8
current_dir := $(shell pwd)

ifndef VLIC_PORT
	VLIC_PORT := 8080
endif

ifndef COUCHDB_PORT
	COUCHDB_PORT := 5984
endif


ifndef IMAGE
<<<<<<< HEAD
	IMAGE := hub5.planet-rocklog.com:5000/vlic/vlic_runner:v7
=======
	IMAGE := hub5.planet-rocklog.com:5000/vlic/vlic_runner:v8
>>>>>>> 8c73469425daf18ddfb4a88592154c638122c7fd
endif


ifndef CONT_NAME
	CONT_NAME := $(shell date +%s | sha256sum | base64 | head -c 32)
endif

persist:
	-mkdir $(CONT_NAME)
	-mkdir $(CONT_NAME)/data
	-mkdir $(CONT_NAME)/tmp
	-mkdir $(CONT_NAME)/tmp/vlic

extract: persist
	test -f $(ARCHIVE) || curl http://hub3.planet-rocklog.com:81/$(ARCHIVE) > $(ARCHIVE)
	-cp $(ARCHIVE) $(CONT_NAME)/tmp/vlic/rocklog-vlic.tar.gz

bash: persist
	echo "Starting bash in new container"
	sudo docker run --name=$(CONT_NAME) -it --restart='always' -p $(COUCHDB_PORT):5984 -p 5987:5986 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log ${IMAGE} bash

couchdb: persist
	echo "Starting bash in new container"
	sudo docker run --name=$(CONT_NAME) -it -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log ${IMAGE} couchdb bash

32bit: extract
	echo "Building medium container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker run --rm --name=$(CONT_NAME) -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/.ssh:/.ssh -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none ${IMAGE} couchdb 32bit

64bit: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker run --rm --name=$(CONT_NAME) -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/.ssh:/.ssh -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none ${IMAGE} couchdb 64bit

64bit-8g: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker run --rm --name=$(CONT_NAME) -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/.ssh:/.ssh -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none ${IMAGE} couchdb 64bit-8g

docker:
	sudo docker build --no-cache -t vlic/vlic_runner:${VERSION} .
	sudo docker tag vlic/vlic_runner:${VERSION} hub5.planet-rocklog.com:5000/vlic/vlic_runner:${VERSION}
	sudo docker push hub5.planet-rocklog.com:5000/vlic/vlic_runner:${VERSION}
