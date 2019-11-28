# Build instructions
# sudo docker build -t vlic/vlic_maker:v5 .

# Run instructions
# sudo docker run -dit -p 22 -p 80 -v ~/.ssh:/var/buildbot/.ssh:ro vlic/vlic_maker:v4

FROM vlic/vlic_base:v4
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

# Install supervisor
RUN apt-get update && \
    apt-get install -y --force-yes supervisor git sudo ssh

# Install nginx
RUN apt-get install -y --force-yes nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

##########################################
#Additional Deps for devops (build etc.)
##########################################
RUN \
 apt-get update && \
 ln -s /usr/bin/nodejs /usr/bin/node

RUN \
    apt-get install curl software-properties-common && \
    curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get install -y nodejs

RUN \
    npm -g i npm nodejs yarn msx version lessc

# Expose HTML Port 80
EXPOSE 80

# Copy custom configuration file
COPY nginx.conf /etc/nginx/sites-available/default

# Set ssh superuser (username: lambdaroyal-anon password: admin)
run mkdir /var/run/sshd
run useradd -m -d /var/buildbot -p sa1aY64JOY94w lambdaroyal-anon
run mkdir /var/buildbot/repository && chown lambdaroyal-anon /var/buildbot/repository
run adduser lambdaroyal-anon sudo
run chsh -s /bin/bash lambdaroyal-anon

# Set supervisord sshd and nginx processes
run /bin/echo -e "[program:sshd]\ncommand=/usr/sbin/sshd -D\n" > /etc/supervisor/conf.d/sshd.conf
run /bin/echo -e "[program:nginx]\ncommand=nginx\n" > /etc/supervisor/conf.d/nginx.conf

# install less
RUN npm -g i less

# Expose container port 22 to a random port in the host.
expose 22

# Allow any node to connect to this container
RUN echo "sshd: ALL" >> /etc/hosts.allow

##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]