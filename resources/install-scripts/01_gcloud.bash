#!/bin/bash
# gcloud sdk install script
# required alpine packages:
# 	- wget
VERSION="226.0.0"
GCLOUD_REMOTE_DOWNLOAD="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${VERSION}-linux-x86_64.tar.gz"
GCLOUD_LOCAL_DOWNLOAD="/tmp/google-cloud-sdk.tar.gz"
mkdir -p /opt
wget "${GCLOUD_REMOTE_DOWNLOAD}" -O "${GCLOUD_LOCAL_DOWNLOAD}"
tar xzvf ${GCLOUD_LOCAL_DOWNLOAD} -C /opt
ln -s /opt/google-cloud-sdk/bin/gcloud /usr/bin/gcloud

