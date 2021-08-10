# Build instructions
# sudo docker build --no-cache -t vlic/vlic_runner:v20 .
# sudo docker tag vlic/vlic_runner:v20 hub5.planet-rocklog.com:5000/vlic/vlic_runner:v20
# sudo docker push hub5.planet-rocklog.com:5000/vlic/vlic_runner:v20

FROM hub5.planet-rocklog.com:5000/vlic/vlic_app:v7
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]