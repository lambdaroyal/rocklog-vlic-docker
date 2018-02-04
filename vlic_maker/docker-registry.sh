#!/usr/bin/env bash

# Rename SSL certificates
# https://community.letsencrypt.org/t/how-to-get-crt-and-key-files-from-i-just-have-pem-files/7348
cd /etc/letsencrypt/live/hub0.planet-rocklog.com/
cp privkey.pem domain.key
cat cert.pem chain.pem > domain.crt
chmod 777 domain.crt
chmod 777 domain.key

# https://docs.docker.com/registry/deploying/
docker run -d -p 5000:5000 --restart=always --name registry \
  -v /etc/letsencrypt/live/hub0.planet-rocklog.com:/certs \
  -v /opt/docker-registry:/var/lib/registry \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
registry:2

