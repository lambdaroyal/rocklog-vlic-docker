#!/bin/bash
sudo docker run -itd -p 22 -v ~/.ssh:/var/buildbot/.ssh:ro vlic/vlic_maker:v1
