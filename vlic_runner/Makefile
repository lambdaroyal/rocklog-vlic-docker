VERSION := v10
current_dir := $(shell pwd)

ifndef VLIC_PORT
	VLIC_PORT := 8080
endif

ifndef COUCHDB_PORT
	COUCHDB_PORT := 5984
endif


ifndef IMAGE
	IMAGE := hub5.planet-rocklog.com:5000/vlic/vlic_runner:$(VERSION)
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
	test -f rocklog-vlic-$(BUILD).tar.gz || curl -H "Circle-Token: b250301c3c80a76602204b52e9705014940d12b7" https://circleci.com/api/v1.1/project/github/lambdaroyal/rocklog-vlic/$(BUILD)/artifacts | grep -o 'https://[^"]*' | wget --verbose --header "Circle-Token: b250301c3c80a76602204b52e9705014940d12b7" --input-file -
	-cp rocklog-vlic.tar.gz rocklog-vlic-$(BUILD).tar.gz 
	-cp rocklog-vlic-$(BUILD).tar.gz $(CONT_NAME)/tmp/vlic/rocklog-vlic.tar.gz
	-rm rocklog-vlic.tar.gz

bash: persist
	echo "Starting bash in new container"
	sudo docker run -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --name=$(CONT_NAME) -it --restart='always' -p $(COUCHDB_PORT):5984 -p 5987:5986 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log ${IMAGE} bash

couchdb: persist
	echo "Starting bash in new container"
	sudo docker run -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --name=$(CONT_NAME) -it -p $(COUCHDB_PORT):5984 -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log ${IMAGE} couchdb bash

64bit: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker run -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --rm --name=$(CONT_NAME) -p $(VLIC_PORT):8080 -p 1$(VLIC_PORT):4050 -v $(current_dir)/$(CONT_NAME)/.ssh:/.ssh -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none ${IMAGE} couchdb 64bit

64bit-8g: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker run -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --rm --name=$(CONT_NAME) -p $(VLIC_PORT):8080 -p 1$(VLIC_PORT):4050 -v $(current_dir)/$(CONT_NAME)/.ssh:/.ssh -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none ${IMAGE} couchdb 64bit-8g

64bit-2g: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker run -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --rm --name=$(CONT_NAME) -p $(VLIC_PORT):8080 -p 1$(VLIC_PORT):4050 -v $(current_dir)/$(CONT_NAME)/.ssh:/.ssh -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none ${IMAGE} couchdb 64bit-2g

64bit-3g: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker run -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --rm --name=$(CONT_NAME) -p $(VLIC_PORT):8080 -p 1$(VLIC_PORT):4050 -v $(current_dir)/$(CONT_NAME)/.ssh:/.ssh -v $(current_dir)/$(CONT_NAME)/data:/data -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/couchdb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none ${IMAGE} couchdb 64bit-3g

docker:
	sudo docker build --no-cache -t vlic/vlic_runner:${VERSION} .
	sudo docker tag vlic/vlic_runner:${VERSION} hub5.planet-rocklog.com:5000/vlic/vlic_runner:${VERSION}
	sudo docker push hub5.planet-rocklog.com:5000/vlic/vlic_runner:${VERSION}
