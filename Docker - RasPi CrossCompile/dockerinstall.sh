#!/bin/bash

sudo apt-get update -y &&
sudo apt-get install docker.io git -y &&
sudo docker pull mitchallen/pi-cross-compile &&

mkdir ~/raspberry &&
cd ~/raspberry &&

git clone https://github.com/mitchallen/pi-hello-cross-compile.git --depth=1 hello &&

sudo docker run -it -v ~/raspberry/hello:/build mitchallen/pi-cross-compile &&

cd ~/raspberry/hello/bin/ &&

ls -l &&

exit 0
