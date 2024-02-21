-Docker cheat sheet with most of the most used commands
Combining commands may work as well, just not for all of them command options


-Install Docker on your Ubuntu machine with a single command
apt-get install docker.io

# Listing

-List containers, including old ones
docker ps
docker ps -a

-List ALL the IDs of ALL docker containers, including the exited ones
docker ps -a -q
docker ps -aq

-List available images and their sizes
docker images

# Pulling

-Download just an image, this will not start up a container
docker pull IMAGE

-Pulling an specific image
docker pull image:version
docker pull nginx:1.14-alpine


# Running

-Run a simple container running nginx inside of it
When you use the "docker run" command, if the image is not currently present in the host, then the needed image will be downloaded first
docker run nginx

-Execute a command in a running container
docker exec CONTAINER cat /etc/hosts

-Running a container in the background, so it will bring you back to the terminal inmedietly
docker run -d IMAGE/IMAGE

-Run a container and automatically be logged into the container terminal use the -it option
In this example, a centos os container, staying automatically at the terminal when started
docker run -it centos bash

-Running a container with a sleep timer in the background
docker run -d centos sleep 100
docker ps -a | grep cent

-Run a command inside of a running container that is running in the background, using the "Exec" command
You can use the containerID or containerName

docker exec COTNAINER COMMAND
docker exec CONTAINER cat /etc/*release*

-Run a new container with your own given name using the --name option
Run a container with the nginx:1.14-alpine image and name it webapp

docker run --name NEW-NAME IMAGE-NAME
docker run -d --name webapp nginx:1.14-alpine

-Going back to the container running in the background
docker attach CONTAINER


# Stoping

-Stop a container
docker stop CONTAINER


# Deleting

-Remove an exited container permanently
docker rm CONTAINER

-Removing all running and stopped containers
docker rm -f $(docker ps -a -q)

-Delete multiple exited containers, by listing them using their containerID separed by spaces
docker rm 2821y7 28173g 9485hd

-Remove an image
First ensure that no containers are running off of that image, if so, you must stop and delete all dependent containers to be able to delete the image
docker rmi IMAGE

-Delete all images on the host, by removing all containers as necessary
Note, use these commands with caution
docker rm -f $(docker ps -a -q)
docker rmi $(docker images -aq)


# Inspect / Monitor

-See additional details about an specific container
docker inspect CONTAINER

-View the logs of a container
docker logs CONTAINER

-To find out the container IP address, run the inspect command followed by the container ID
Search for the network section down below, and look up the key called "IPAddress"

docker inspect CONTAINER-ID
docker inspect 1608fe2438b6

