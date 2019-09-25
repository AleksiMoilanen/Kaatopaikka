#sudo docker build -t _name_ _path_

#Get latest ubuntu versio
FROM ubuntu:latest

#Variables
ARG IP_ADDRESS=178.55.186.181
ARG USERNAME=pi
ARG PASSWORD=rasb3rry
ARG QT_VERSION=5.12.3
ARG PORT=2222

#Update and install required softwares
RUN apt-get update -y && \
    apt-get install git wget python rsync cmake g++ openssh-client sshpass -y

#Make directory for crosscompiler and download raspberry pi tools
RUN mkdir ~/raspi

WORKDIR /root/raspi

RUN git clone https://github.com/raspberrypi/tools

#Make directory for rpi files
RUN mkdir sysroot sysroot/usr sysroot/opt

#Generate ssh-key. -q: Silence ssh-keygen, -N '': Provides a new passphrase for the key, -f id_rsa: Specifies name of the file in which to store the created key.
RUN ssh-keygen -q -N '' -f id_rsa

#Copy ssh-key to rpi. Sshpass will pass given password for later requests. StrictHostKeyChecking=no make ssh-copy-id ignore hostkey checking
#Sshpass: -p $PASSWORD given password
#ssh-copy-id: -o: (option) StrictHostKeyChecking=no (will pass hostkey checking), -f (Don't check if the key is already configured as an authorized key on the server),
# -i (keyfile) id_rsa (our generated keyfile) $USERNAME@$IP_ADDRESS (username@ipaddress with our variables)
RUN sshpass -p $PASSWORD ssh-copy-id -o StrictHostKeyChecking=no -f -i id_rsa -p $PORT $USERNAME@$IP_ADDRESS

#Sync rpi files. 

# --rsh: This option allows you to choose an alternative remote shell program to use for communication between the local and remote copies of rsync.
# -a (archive, ), -v (verbose, print what files are being transferred and summary), -z (compress, compresses the file data)
RUN rsync --rsh="sshpass -p $PASSWORD ssh -p $PORT -o StrictHostKeyChecking=no" -avz $USERNAME@$IP_ADDRESS:/lib sysroot
RUN rsync --rsh="sshpass -p $PASSWORD ssh -p $PORT -o StrictHostKeyChecking=no" -avz $USERNAME@$IP_ADDRESS:/usr/include sysroot/usr
#With: "; exit 0" we can make docker ignore errors
RUN rsync --rsh="sshpass -p $PASSWORD ssh -p $PORT -o StrictHostKeyChecking=no" -avz $USERNAME@$IP_ADDRESS:/usr/lib sysroot/usr ; exit 0
RUN rsync --rsh="sshpass -p $PASSWORD ssh -p $PORT -o StrictHostKeyChecking=no" -avz $USERNAME@$IP_ADDRESS:/opt/vc sysroot/opt

RUN wget https://raw.githubusercontent.com/Kukkimonsuta/rpi-buildqt/master/scripts/utils/sysroot-relativelinks.py
RUN chmod +x sysroot-relativelinks.py
RUN ./sysroot-relativelinks.py sysroot

RUN git clone git://code.qt.io/qt/qtbase.git -b ${QT_VERSION}

WORKDIR /root/raspi/qtbase

#RUN rm ~/raspi/qtbase/mkspecs/devices/linux-rasp-pi3-g++/qmake.conf
#COPY qmake.conf /root/raspi/qtbase/mkspecs/devices/linux-rasp-pi3-g++/qmake.conf

#RUN ./configure -release -opengl es2 -device linux-rasp-pi-g++ -device-option CROSS_COMPILE=/root/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf- -sysroot /root/raspi/sysroot -opensource -confirm-license -skip qtwayland -skip qtlocation -skip qtscript -make libs -prefix /usr/local/qt5pi -extprefix /root/raspi/qt5pi -hostprefix /root/raspi/qt5 -no-use-gold-linker -v -no-gbm -no-gcc-sysroot
RUN ./configure -release -opengl es2 -device linux-rasp-pi-g++ -device-option CROSS_COMPILE=/root/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf- -sysroot /root/raspi/sysroot -opensource -confirm-license -skip qtwayland -skip qtlocation -skip qtscript -make libs -prefix /usr/local/qt5pi -extprefix /root/raspi/qt5pi -hostprefix /root/raspi/qt5 -no-use-gold-linker -v -no-gbm

RUN make -j3 && make install


WORKDIR /root/raspi/

RUN mkdir modules

WORKDIR /root/raspi/modules

RUN git clone git://code.qt.io/qt/qtdeclarative.git -b ${QT_VERSION}
RUN git clone git://code.qt.io/qt/qtquickcontrols.git -b ${QT_VERSION}
RUN git clone git://code.qt.io/qt/qtquickcontrols2.git -b ${QT_VERSION}

WORKDIR /root/raspi/modules/qtdeclarative

RUN ~/raspi/qt5/bin/qmake && \
    make -j3 && \
    make install

WORKDIR /root/raspi/modules/qtquickcontrols

RUN ~/raspi/qt5/bin/qmake && \
    make -j3 && \
    make install

WORKDIR /root/raspi/modules/qtquickcontrols2

RUN ~/raspi/qt5/bin/qmake && \
    make -j3 && \
    make install

WORKDIR /root/raspi

RUN rsync --rsh="sshpass -p $PASSWORD ssh -p $PORT -o StrictHostKeyChecking=no" -avz /root/raspi/qt5pi $USERNAME@$IP_ADDRESS:/usr/local