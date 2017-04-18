FROM vlic/vlic_app:v2
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

# Install supervisor
RUN apt-get update && \
    apt-get install -y --force-yes supervisor git sudo ssh

# Install lessc
RUN npm install -g less glob node-version-assets

# Install nginx
RUN apt-get install -y --force-yes nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

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
CMD ["/usr/bin/supervisord", "-n"]
