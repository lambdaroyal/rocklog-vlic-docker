#!/bin/bash
mkdir -p repository
_user=$(stat -c '%U' .)
_version="v5"
sudo docker pull hub5.planet-rocklog.com:5000/vlic/vlic_maker:$_version
sudo docker run --name=vlic_maker -itd -p 23:22 -p 81:80 -v ~/.ssh:/var/buildbot/.ssh:ro -v repository:/var/buildbot/repository:rw hub5.planet-rocklog.com:5000/vlic/vlic_maker:$_version $_user $(id -u $_user)
