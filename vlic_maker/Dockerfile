# Build instructions
# sudo docker build -t vlic/vlic_maker:v4 .

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
 apt-get install -y --force-yes npm && \
 npm i -g n && \
 n 10.15.3 && \
 npm install -g bower && \
 ln -s /usr/bin/nodejs /usr/bin/node

# Install lessc
RUN npm install -g less glob node-version-assets msx

RUN \
    curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install -y nodejs
RUN \
 curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN \
 echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN \
 apt-get update && apt-get install yarn

# Expose HTML Port 80
EXPOSE 80

# Copy custom configuration file
COPY nginx.conf /etc/nginx/sites-available/default

# Set ssh superuser (username: lambdaroyal-anon password: admin)
run mkdir /var/run/sshd
run useradd -m -d /var/buildbot -p sa1aY64JOY94w lambdaroyal-anon
run mkdir /var/buildbot/repository && chown lambdaroyal-anon /var/buildbot/repository

# Set supervisord sshd and nginx processes
run /bin/echo -e "[program:sshd]\ncommand=/usr/sbin/sshd -D\n" > /etc/supervisor/conf.d/sshd.conf
run /bin/echo -e "[program:nginx]\ncommand=nginx\n" > /etc/supervisor/conf.d/nginx.conf

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