FROM vlic/vlic_app:v1
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

##########################################
#1. build from source, add private keys for
#2. json webtoken generation
#3. update web dependencies
##########################################

ADD .ssh/ /keys
ADD rocklog-vlic/ /rocklog-vlic

RUN cd /rocklog-vlic/public/app && \
    bower --allow-root -s update 

RUN cd /rocklog-vlic && \
    lein do clean, javac, uberjar



##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
