#!/bin/bash

echo Enter your Raspberry pi IP address:
read ipAddress
while [ -z "$ipAddress" ]; do
    echo Raspberry pi IP address cannot be empty:
    read ipAddress
done

echo Enter your Raspberry pi username:
read userName
while [ -z "$userName" ]; do
  echo Raspberry pi username cannot be empty:
  read userName
done

echo "Do you want to update your Raspberry pi? (y/n)":
read raspberryUpdate
while [ -z "$raspberryUpdate" ]; do
  echo Answer y or n:
  read raspberryUpdate
done

#ssh-keygen
#ssh-copy-key $userName@$ipAddress

#Raspin päivitys
#if [ $raspberryUpdate == 'Y' ] || [ $raspberryUpdate == 'y' ]
#then
echo Updating Raspberry
ssh $userName@$ipAddress 'sudo apt-get update && sudo apt-get upgrade -y'
#fi

echo Loading missing libraries
ssh $userName@$ipAddress "sudo apt-get build-dep qt4-x11 && sudo apt-get build-dep libqt5gui5 && sudo apt-get install libudev-dev libinput-dev libts-dev libxcb-xinerama0-dev libxcb-xinerama0 && sudo mkdir /usr/local/qt5pi && sudo chown pi:pi /usr/local/qt5pi"

#sysroot synkronointi Raspilta tietokoneelle
echo Synchronizing sysroot from raspberry
rsync -avz pi@$ipAddress:/lib sysroot
rsync -avz pi@$ipAddress:/usr/include sysroot/usr
rsync -avz pi@$ipAddress:/usr/lib sysroot/usr
rsync -avz pi@$ipAddress:/opt/vc sysroot/opt

./sysroot-relativelinks.py sysroot

#Qt5Pi tiedostojen synkronointi tietokoneelta Raspille
echo Synchronizing Qt files to raspberry
rsync -avz qt5pi pi@$ipAddress:/usr/local


echo Updating libraries and synchronizing files should be ready
