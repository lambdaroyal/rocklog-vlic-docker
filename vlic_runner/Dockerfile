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

#Install Java 64bit/32bit

RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update

RUN \                                                 
    apt install   -y --force-yes openjdk-8-jdk -t jessie-backports ca-certificates-java

##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

