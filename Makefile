clone:
	mkdir -p .ssh
	cp ~/.ssh/id_rsa* ./.ssh 
	chmod +rx docker-entrypoint.sh
	rm -r -f rocklog-vlic
	git clone git@github.com:lambdaroyal/rocklog-vlic.git

build:
	sudo docker build -t vlic/vlic_runner:v1 .

bash:
	sudo docker run -t -p 5984:5984 -p 8080:8080 -it vlic/vlic_runner:v1 couchdb bash

medium:
	sudo docker run -d -t -p 5984:5984 -p 8080:8080 -it vlic/vlic_runner:v1 couchdb medium
