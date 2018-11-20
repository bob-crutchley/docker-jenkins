FROM jenkins/jenkins:lts

# docker
USER root
RUN apt-get update 
RUN apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey 
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" 
RUN apt-get update 
RUN apt-get -y install docker-ce
RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apt install -y wget maven

# GCloud & Kubectl
ENV GCLOUD_REMOTE_DOWNLOAD="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-213.0.0-linux-x86_64.tar.gz"
ENV GCLOUD_LOCAL_DOWNLOAD="/tmp/google-cloud-sdk.tar.gz"
RUN wget "${GCLOUD_REMOTE_DOWNLOAD}" -O "${GCLOUD_LOCAL_DOWNLOAD}"
RUN tar xzvf ${GCLOUD_LOCAL_DOWNLOAD} -C /opt
RUN ln -s /opt/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
RUN gcloud components install -q kubectl
RUN ln -s /opt/google-cloud-sdk/bin/kubectl /usr/bin/kubectl

# plugins
USER jenkins
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/init.groovy
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

