VERSION=v5
all:
	sudo docker build -t vlic/vlic_maker:${VERSION} .
	sudo docker tag vlic/vlic_maker:${VERSION} hub5.planet-rocklog.com:5000/vlic/vlic_maker:${VERSION}
	sudo docker push hub5.planet-rocklog.com:5000/vlic/vlic_maker:${VERSION}
