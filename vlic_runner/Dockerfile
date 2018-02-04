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
# Override std config
RUN \
    sed -e 's/^bind_address = .*$/bind_address = 0.0.0.0/' -i /opt/couchdb/etc/default.ini && \
    sed -e 's/^database_dir = .*$/database_dir = \/data/' -i /opt/couchdb/etc/default.ini && \
    sed -e 's/^view_index_dir = .*$/view_index_dir = \/data/' -i /opt/couchdb/etc/default.ini

# Add configuration
COPY vm.args /opt/couchdb/etc/

##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

