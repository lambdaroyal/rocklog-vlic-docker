# Build instructions
# sudo docker build --no-cache -t vlic/vlic_runner:v10 .
# sudo docker tag vlic/vlic_runner:v10 hub5.planet-rocklog.com:5000/vlic/vlic_runner:v10
# sudo docker push hub5.planet-rocklog.com:5000/vlic/vlic_runner:v10

FROM hub5.planet-rocklog.com:5000/vlic/vlic_app:v5
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

RUN \
    	DEBIAN_FRONTEND=noninteractive \
	apt-get update && \
	apt-get install -y --force-yes \
    	libfontconfig1 libgcc1 

##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

