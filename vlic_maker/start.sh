#!/bin/bash
sudo docker run --name=vlic_maker -itd -p 23:22 -p 81:80 -v ~/.ssh:/var/buildbot/.ssh:ro vlic/vlic_maker:v4
