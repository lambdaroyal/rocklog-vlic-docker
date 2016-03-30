FROM vlic/vlic_app:v2
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

# Install buildbot
RUN apt-get update && \
    apt-get install -y --force-yes buildbot buildbot-slave supervisor git sudo ssh

# Set ssh superuser (username: lambdaroyal-anon password: admin)
run mkdir /var/run/sshd
run useradd -m -d /var/buildbot -p sa1aY64JOY94w lambdaroyal-anon

# Create buildbot configuration
run cd /var/buildbot; sudo -u lambdaroyal-anon sh -c "buildbot create-master master"
run cp -a /var/buildbot/master/master.cfg.sample \
    /var/buildbot/master/master.cfg
run cd /var/buildbot; sudo -u lambdaroyal-anon sh -c \
    "buildslave create-slave slave localhost:9989 slave1 pass"

# Set supervisord buildbot and sshd processes
run /bin/echo -e "[program:sshd]\ncommand=/usr/sbin/sshd -D\n" > /etc/supervisor/conf.d/sshd.conf
run /bin/echo -e "[program:buildmaster]\n\
command=twistd --nodaemon --no_save -y buildbot.tac\n\
directory=/var/buildbot/master\n\
user=lambdaroyal-anon\n\n\
[program:buildworker]\n\
command=twistd --nodaemon --no_save -y buildbot.tac\n\
directory=/var/buildbot/slave\n\
user=lambdaroyal-anon\n" > /etc/supervisor/conf.d/buildbot.conf

# Setup running docker container buildbot process
# Make host port 8010 match container port 8010
expose :8010
# Expose container port 22 to a random port in the host.
expose 22

RUN echo "sshd: ALL" >> /etc/hosts.allow


##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
cmd ["/usr/bin/supervisord", "-n"]
