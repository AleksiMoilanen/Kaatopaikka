#!/bin/bash

#sysroot synkronointi Raspilta tietokoneelle
sshpass -p $2 ssh $1@$3 "ssh sudo apt-get build-dep qt4-x11 -y ; sudo apt-get build-dep libqt5gui5 -y ; sudo apt-get install libudev-dev libinput-dev libts-dev libxcb-xinerama0-dev libxcb-xinerama0 -y ; sudo mkdir /usr/local/qt5pi ; sudo chown pi:pi /usr/local/qt5pi"
#rsync --rsh="sshpass -p $2 ssh -p $4 -o StrictHostKeyChecking=no" -avz /root/raspi/qt5pi $1@$3:/usr/local