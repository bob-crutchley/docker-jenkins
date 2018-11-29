#!/bin/bash
# kubectl install script
# required programs:
# 	- gcloud sdk
gcloud components install -q kubectl
ln -s /opt/google-cloud-sdk/bin/kubectl /usr/bin/kubectl

