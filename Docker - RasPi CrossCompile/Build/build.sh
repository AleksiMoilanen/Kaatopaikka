#!/bin/bash

cd $1
/root/raspi/qt5/bin/qmake *.pro -spec devices/linux-rasp-pi-g++ CONFIG+=debug CONFIG+=qml_debug && /usr/bin/make qmake_all
make -j3

sshpass -p $3 scp -P $5 /root/build/$1 $2@$4:/home/pi/build