FROM alpine:latest

COPY packages.txt /tmp/packages.txt
RUN apk add $(cat /tmp/packages.txt)

# install scripts
COPY ./install-scripts /tmp/install-scripts
RUN for script in $(ls /tmp/install-scripts); do /tmp/install-scripts/${script}; done

# plugins
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
COPY init.groovy /root/.jenkins/init.groovy.d/init.groovy
#COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN /usr/local/bin/install-plugins.bash < /usr/share/jenkins/ref/plugins.txt
ENTRYPOINT ["java", "-Djenkins.install.runSetupWizard=false", "-jar", "/usr/share/webapps/jenkins/jenkins.war"]
