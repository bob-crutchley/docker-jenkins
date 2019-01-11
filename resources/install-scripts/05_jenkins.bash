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
mkdir -p ${JENKINS_HOME}
adduser -S jenkins
addgroup jenkins
wget https://updates.jenkins-ci.org/latest/jenkins.war -O ${JENKINS_HOME}/jenkins.war 
chown -R jenkins:jenkins ${JENKINS_HOME}
