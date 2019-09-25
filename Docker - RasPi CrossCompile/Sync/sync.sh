#!/bin/bash

rsync --rsh="sshpass -p $2 ssh -p $4 -o StrictHostKeyChecking=no" -avz /root/raspi/qt5pi $1@$3:/usr/local