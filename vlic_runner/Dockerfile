# Build instructions
# sudo docker build -t vlic/vlic_runner:v4 .

FROM vlic/vlic_app:v4
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

##########################################
#ecdsa keypair for json web tokens
##########################################
RUN \
 ssh-keygen -q -N "" -t ecdsa -f ~/.ssh/id_ecdsa

##########################################
#CouchDB Config
##########################################
# Add configuration
COPY local.ini /opt/couchdb/etc/local.d/
COPY vm.args /opt/couchdb/etc/

##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

