clone:
	mkdir -p .ssh
	cp ~/.ssh/id_rsa* ./.ssh 
	chmod +rx docker-entrypoint.sh
	rm -r -f rocklog-vlic
	git clone git@github.com:lambdaroyal/rocklog-vlic.git -b $(branch)
	-mkdir rocklog-vlic/resources/geolite2
	-curl http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz > rocklog-vlic/resources/geolite2/GeoLite2-City.mmdb.gz
	-gzip -d rocklog-vlic/resources/geolite2/GeoLite2-City.mmdb.gz

build:
	sudo docker build -t vlic/vlic_runner:v1 .

bash:
	sudo docker run -t -p 5984:5984 -p 8080:8080 -it vlic/vlic_runner:v1 couchdb bash

medium:
	sudo docker run -d -t -p 5984:5984 -p 8080:8080 -it vlic/vlic_runner:v1 couchdb medium
