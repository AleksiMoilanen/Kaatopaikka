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

`sudo docker run -v $PWD/:/root/build/ {image name} {project name} {username} {password} {ip address} {port}`

Example:

`sudo docker run -v $PWD/:/root/build/ aleksi/build Master-UI pi rasberry 192.168.100.60 22`


#### Variables:

* image name = docker image name
* project name = pro filename without .pro 
* username = Raspberry Pi username
* password = Raspberry Pi password
* ip address = Raspberry Pi IP address
* port = Raspberry Pi SSH connection port
