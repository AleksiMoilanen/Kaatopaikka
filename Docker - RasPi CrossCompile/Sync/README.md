# Sync - Building docker from Dockerfile 

```sudo docker build -t {image name} . --build-arg {ARG}={VALUE} ```

#### Arguments:

* USERNAME = Raspberry Pi username
* PASSWORD = Raspberry Pi password
* IP_ADDRESS = Raspberry Pi IP address
* PORT = Raspberry Pi SSH connetion port
* QT_VERSION = Used QT version


# Loading image from .tar

```sudo docker load -i {.tar file}```

# Pulling image from Docker Hub

```docker pull aleksim/sync```

# Running Sync container 

```sudo docker run {image name} {username} {password} {ip address} {port}```

#### Variables:

* image name = docker image name
* username = Raspberry Pi username
* password = Raspberry Pi password
* ip address = Raspberry Pi IP address
* port = Raspberry Pi SSH connection port



