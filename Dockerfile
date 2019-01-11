FROM alpine:latest

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
ENV JENKINS_HOME="/home/jenkins"
ENV BUILD_RESOURCES="/tmp/resources"

# copy resource files
COPY resources ${BUILD_RESOURCES}

# alpine packages
RUN apk add $(cat ${BUILD_RESOURCES}/alpine_packages.txt)

# allow jenkins to run any command as sudo
RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# run all install scripts
RUN ${BUILD_RESOURCES}/install-scripts/00_install.bash

# jenkins initialisation scripts
COPY init.groovy.d ${JENKINS_HOME}/init.groovy.d

RUN chown -R jenkins:jenkins ${JENKINS_HOME}

USER jenkins
RUN echo "alias docker=\"sudo docker\"" >> ${JENKINS_HOME}/.bashrc
ENTRYPOINT java ${JAVA_OPTS} -jar ${JENKINS_HOME}/jenkins.war

