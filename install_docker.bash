#!/bin/bash
# Installs Docker from Docker
# (as opposed to using the Ubuntu
# version which lacks the Docker
# module)

# install docker
curl -sSL https://get.docker.com/gpg | sudo apt-key add -
curl -sSL https://get.docker.com/ | sh

# build class container
docker build -t ansibleclass/class_instance /home/ubuntu/class_instance/.

# provision containers
docker run -p 172.31.22.101:22:22 -p 172.31.22.101:80:80 -t --name webapp01 -d ansibleclass/class_instance
docker run -p 172.31.22.102:22:22 -p 172.31.22.102:80:80 -t --name webapp02 -d ansibleclass/class_instance
docker run -p 172.31.22.103:22:22 -p 172.31.22.103:80:80 -t --name webapp03 -d ansibleclass/class_instance
docker run -p 172.31.22.201:22:22 -p 172.31.22.201:80:80 -t --name testapp01 -d ansibleclass/class_instance
docker run -p 172.31.22.202:22:22 -p 172.31.22.202:80:80 -t --name testapp02 -d ansibleclass/class_instance
docker run -p 172.31.22.203:22:22 -p 172.31.22.203:80:80 -t --name testapp03 -d ansibleclass/class_instance

