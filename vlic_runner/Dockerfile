# Build instructions
# sudo docker build -t vlic/vlic_runner:v6 .
# sudo docker tag vlic/vlic_runner:v6 hub5.planet-rocklog.com:5000/vlic/vlic_runner:v6

FROM hub5.planet-rocklog.com:5000/vlic/vlic_app:v5
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

