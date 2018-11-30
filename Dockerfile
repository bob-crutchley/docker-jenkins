FROM alpine:latest
# load environment variables
COPY ENV_VARS /etc/profile.d/ENV_VARS

# copy resource files
COPY resources ${BUILD_RESOURCES}

# alpine packages
RUN apk add $(cat ${BUILD_RESOURCES}/packages.txt)

# run all install scripts
RUN ${BUILD_RESOURCES}/install-scripts/00_install.bash

# jenkins initialisation scripts
COPY init.groovy.d ${JENKINS_HOME}/init.groovy.d

ENTRYPOINT java -jar ${JENKINS_HOME}/jenkins.war

