#!/bin/bash
# install custom vim configurations
# required alpine packages:
#  - git
#  - vim
git clone https://github.com/bob-crutchley/vim /tmp/vim
pushd /tmp/vim
./install
popd#
