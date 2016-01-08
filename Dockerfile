FROM vlic/vlic_app:v1
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

ADD .ssh/ /keys
ADD rocklog-vlic/ /rocklog-vlic

RUN cd /rocklog-vlic/public/app && \
    bower --allow-root -s update 

RUN cd /rocklog-vlic && \
    lein uberjar



##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
