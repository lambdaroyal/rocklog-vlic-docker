#!/bin/bash
mkdir -p repository
sudo docker run --name=vlic_maker -itd -p 23:22 -p 81:80 -v ~/.ssh:/var/buildbot/.ssh:ro hub5.planet-rocklog.com:5000/vlic/vlic_maker:v5
