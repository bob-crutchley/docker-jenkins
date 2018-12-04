FROM alpine:latest
# load environment variables
COPY ENV_VARS.sh /etc/profile.d/ENV_VARS.sh
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
ENV JENKINS_HOME="/home/jenkins"
ENV BUILD_RESOURCES="/tmp/resources"

# copy resource files
COPY resources ${BUILD_RESOURCES}

# alpine packages
RUN apk add $(cat ${BUILD_RESOURCES}/packages.txt)

# run all install scripts
RUN ${BUILD_RESOURCES}/install-scripts/00_install.bash

# jenkins initialisation scripts
COPY init.groovy.d ${JENKINS_HOME}/init.groovy.d

ENTRYPOINT java ${JAVA_OPTS} -jar ${JENKINS_HOME}/jenkins.war

