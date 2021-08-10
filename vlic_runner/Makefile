VERSION := v20
current_dir := $(shell pwd)

ifndef VLIC_PORT
	VLIC_PORT := 8080
endif

ifndef IMAGE
	IMAGE := hub5.planet-rocklog.com:5000/vlic/vlic_runner:$(VERSION)
endif


ifndef CONT_NAME
	CONT_NAME := $(shell date +%s | sha256sum | base64 | head -c 32)
endif

persist:
	-mkdir $(CONT_NAME)
	-mkdir $(CONT_NAME)/tmp
	-mkdir $(CONT_NAME)/tmp/vlic

extract: persist
	test -f $(ARCHIVE) || curl http://hub8.planet-rocklog.com/releases/$(ARCHIVE) > $(ARCHIVE)
	-cp $(ARCHIVE) $(CONT_NAME)/tmp/vlic/rocklog-vlic.tar.gz

bash: persist
	echo "Starting bash in new container"
	sudo docker --env-file .env run -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --name=$(CONT_NAME) -it --restart='always' -p $(VLIC_PORT):8080 -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log ${IMAGE} bash

64bit: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker --env-file .env run -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --rm --name=$(CONT_NAME) -p $(VLIC_PORT):8080 -p 1$(VLIC_PORT):4050 -v $(current_dir)/$(CONT_NAME)/.ssh:/.ssh -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/mongodb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none ${IMAGE} 64bit

64bit-8g: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker --env-file .env run -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --rm --name=$(CONT_NAME) -p $(VLIC_PORT):8080 -p 1$(VLIC_PORT):4050 -v $(current_dir)/$(CONT_NAME)/.ssh:/.ssh -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/mongodb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none ${IMAGE} 64bit-8g

64bit-2g: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker --env-file .env run -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --rm --name=$(CONT_NAME) -p $(VLIC_PORT):8080 -p 1$(VLIC_PORT):4050 -v $(current_dir)/$(CONT_NAME)/.ssh:/.ssh -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/mongodb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none ${IMAGE} 64bit-2g

64bit-3g: extract
	echo "Building big container with unique data dir $(CONT_NAME) with archive $(ARCHIVE) for customer data"
	-mkdir $(CONT_NAME)/log
	-sudo docker rm -f $(CONT_NAME)
	sudo docker run --env-file .env -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --rm --name=$(CONT_NAME) -p $(VLIC_PORT):8080 -p 1$(VLIC_PORT):4050 -v $(current_dir)/$(CONT_NAME)/.ssh:/.ssh -v $(current_dir)/$(CONT_NAME)/tmp/vlic:/tmp/vlic -v $(current_dir)/$(CONT_NAME)/log:/usr/local/var/log/mongodb/ -v /etc/localtime:/etc/localtime:ro --log-driver=none ${IMAGE} 64bit-3g 

docker-build:
	sudo docker build --no-cache -t vlic/vlic_runner:${VERSION} .

docker-push:	docker-build
	sudo docker tag vlic/vlic_runner:${VERSION} hub5.planet-rocklog.com:5000/vlic/vlic_runner:${VERSION}
	sudo docker push hub5.planet-rocklog.com:5000/vlic/vlic_runner:${VERSION}

