#!/bin/bash
# install jenkins for alpine linux
# required alpine packages:
#  - wget
#  - openjdk8
#  - openjdk8-jre
#  - openjdk8-jre-base
#  - freetype
#  - ttf-dejavu
#  - xvfb
#  - fontconfig
mkdir -p /home/jenkins
adduser -S jenkins
wget https://updates.jenkins-ci.org/latest/jenkins.war -O /home/jenkins/jenkins.war 

