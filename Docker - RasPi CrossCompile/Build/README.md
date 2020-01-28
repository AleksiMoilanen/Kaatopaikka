# Building docker from Dockerfile 

Example:

`sudo docker build -t {image name} . --build-arg USERNAME=pi --build-arg PASSWORD=raspberry --build-arg IP_ADDRESS=192.168.100.60`

#### Arguments:

* USERNAME = Raspberry Pi username (Default: pi)
* PASSWORD = Raspberry Pi password (Default: raspberry)
* IP_ADDRESS = Raspberry Pi IP address
* PORT = Raspberry Pi SSH connetion port (Default: 22)
* QT_VERSION = Used QT version (Default: 5.12.3)

# Running docker image

sudo docker run -t -d {image name}

## Execute scripts:

Hae container id komennolla:

sudo docker ps -a 

### SyncFromDocker2Pi

sudo docker exec -t {container id} /root/raspi/SyncFromDocker2Pi.sh {username} {password} {ip address} {port}

### SyncFromPi2Docker

sudo docker exec -t {container id} /root/raspi/SyncFromPi2Docker.sh {username} {password} {ip address} {port}

### Build

sudo docker cp $PWD/ {container id}:/root/build
sudo docker exec -t {container id} /root/raspi/Build.sh {project name} {username} {password} {ip address} {port}`
