FROM jenkins/jenkins:lts
USER root
# docker
RUN curl https://get.docker.com | bash
# docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
# kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN sudo mv ./kubectl /usr/local/bin/kubectl
# sudo install and configuration
RUN apt install -y sudo
RUN echo 'jenkins ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER jenkins

