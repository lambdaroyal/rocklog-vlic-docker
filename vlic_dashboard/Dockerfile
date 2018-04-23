# Build instructions
# sudo docker build -t vlic/vlic_dashboard:v1 .

# Run instructions
# sudo docker run -dit -p 24:22 -p 8983:8983 -p 8881:8881 -v ~/.ssh:/var/buildbot/.ssh:ro vlic/vlic_dashboad:v1

FROM vlic/vlic_base:v4
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

# Install supervisor
RUN apt-get update && \
    apt-get install -y --force-yes supervisor git sudo ssh

# Install nginx
RUN apt-get install -y --force-yes nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose PORTS
EXPOSE 8983
EXPOSE 8881
EXPOSE 22

# Set ssh superuser (username: lambdaroyal-anon password: admin)
run mkdir /var/run/sshd
run useradd -m -d /var/buildbot -p sa1aY64JOY94w lambdaroyal-anon
run mkdir /var/buildbot/repository && chown lambdaroyal-anon /var/buildbot/repository

# Set supervisord sshd and nginx processes
run /bin/echo -e "[program:sshd]\ncommand=/usr/sbin/sshd -D\n" > /etc/supervisor/conf.d/sshd.conf
run /bin/echo -e "[program:nginx]\ncommand=nginx\n" > /etc/supervisor/conf.d/nginx.conf

# Allow any node to connect to this container
RUN echo "sshd: ALL" >> /etc/hosts.allow

##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]