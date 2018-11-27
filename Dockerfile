FROM alpine:latest

COPY packages.txt /tmp/packages.txt
RUN apk add $(cat /tmp/packages.txt)

# GCloud & Kubectl
ENV GCLOUD_REMOTE_DOWNLOAD="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-226.0.0-linux-x86_64.tar.gz"
ENV GCLOUD_LOCAL_DOWNLOAD="/tmp/google-cloud-sdk.tar.gz"
RUN mkdir -p /opt
RUN wget "${GCLOUD_REMOTE_DOWNLOAD}" -O "${GCLOUD_LOCAL_DOWNLOAD}"
RUN tar xzvf ${GCLOUD_LOCAL_DOWNLOAD} -C /opt
RUN ln -s /opt/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
RUN gcloud components install -q kubectl
RUN ln -s /opt/google-cloud-sdk/bin/kubectl /usr/bin/kubectl

#COPY install-plugins.bash /usr/local/bin/install-plugins.bash
#COPY jenkins-support /usr/local/bin/jenkins-support
#RUN chmod +x /usr/local/bin/install-plugins.bash
# plugins
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
COPY init.groovy /root/.jenkins/init.groovy.d/init.groovy
#COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN /usr/local/bin/install-plugins.bash < /usr/share/jenkins/ref/plugins.txt
ENTRYPOINT ["java", "-Djenkins.install.runSetupWizard=false", "-jar", "/usr/share/webapps/jenkins/jenkins.war"]
