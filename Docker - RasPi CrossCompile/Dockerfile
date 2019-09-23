#sudo docker build _name_ _path_

FROM ubuntu:latest

ARG IP_ADDRESS=192.168.100.40
ARG USERNAME=pi

RUN apt-get update -y && \
    apt-get install git wget python rsync cmake g++ openssh-client sshpass -y

RUN mkdir ~/raspi && \
    cd ~/raspi 
#&& \
#    git clone https://github.com/raspberrypi/tools

RUN mkdir sysroot sysroot/usr sysroot/opt

RUN ssh-keygen -q -N '' -f id_rsa
RUN sshpass -p raspberry ssh-copy-id -o StrictHostKeyChecking=no -f -i id_rsa $USERNAME@$IP_ADDRESS

RUN rsync --rsh="sshpass -p raspberry ssh -o StrictHostKeyChecking=no" -avz $USERNAME@$IP_ADDRESS:/lib sysroot
RUN rsync --rsh="sshpass -p raspberry ssh -o StrictHostKeyChecking=no" -avz $USERNAME@$IP_ADDRESS:/usr/include sysroot/usr
RUN rsync --rsh="sshpass -p raspberry ssh -o StrictHostKeyChecking=no" -avz --ignore-errors $USERNAME@$IP_ADDRESS:/usr/lib sysroot/usr
RUN rsync --rsh="sshpass -p raspberry ssh -o StrictHostKeyChecking=no" -avz $USERNAME@$IP_ADDRESS:/opt/vc sysroot/opt