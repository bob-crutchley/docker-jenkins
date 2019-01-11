#!/bin/bash
version="18.09.1"
wget https://download.docker.com/linux/static/stable/x86_64/docker-${version}.tgz -O /tmp/docker.tar.gz
tar -xzvf /tmp/docker.tar.gz -C /opt
for file in $(ls /opt/docker); do
	ln -s /opt/docker/${file} /usr/bin/${file}
done

