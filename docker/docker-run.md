The following are more like "advance" docker run commands

# TAGS

-Run a container with a different version that is not the "latest", specifiying what version to run using the "image tag" using the semicolong symbol (:)
-So, the number after de semicolon (:) and the image name, is the TAG
-When not specifying a tag, docker will use the "latest" version/tag

docker run IMAGE:VERSION
docker run redis:4.0


# INTERACTIVE MODE

-When you want to run a container while providing your own INPUT, use the -i option, which is telling docker run to run in "interactive mode", so when the container starts you can automatically enter your inputs
-And then to use map the "containers terminal" at start, use the -t option too
Which stands for "pseudo Terminal"
-So with the combination of -it we are will be attached to the terminal as well as in interactive mode on the recently started container

docker run -it CONTAINER/IMAGE
docker run -it kodekloud/simple-prompt-docker


# PORT MAPPING
-Remember, the underlying host where Docker is installed, is called:
Docker Host, or, Docker Engine

-When we run a container, we can see it on our host just fine, but how does another user access my containerized application? What IP to use to access it from a web browser? there are 2 options
1) use the IP of the docker container, every docker container gets an IP assigned by default, but remember that this is an internal IP and is only accessible within the docker host
2) use the IP of the docker host,
but for this to work, you must have mapped the port inside the docker container to a free port on the docker host

-For example, if I want the user to access my application through Port 80 on my Docker Host, I could map port80 of my local hot to port 5000 on the Docker container using the -p option in the run command

docker run -p 80:5000 CONTAINER : IMAGE
docker run -p 80:5000 kodekloud/simple-webapp

LOCAL HOST PORT : CONTAINER PORT 

And so all traffic on Port 80 on my Docker Host will get routed to port 5000 inside the Docker Container, as specified by the docker run command

-This way you can run multiple instances of your application and MAP them to different ports on the Docker Host, or on other instances of another different applications also on different ports

Like an instance of mysql that runs a database on my docker host and listens on the default mysql port, which is 3306

docker run -p 3306 : 3306 mysql

-And of course, you cannot map to the same port on the Docker Host more than once, meaning the ports on the Docker Host can only be use once at a time

-You cannot add port mapping while the container is running, it would need to be stop first
Then re-run the docker run command again, but this time mapping the ports as needed

docker run -p 8080:8080 jenkins

LOCAL PORT : CONTAINER PORT


# VOLUME MAPPING
-How data is "persistent" in a Docker Container

-For example, you run a database mysql container, the data files are stored in location for:
/var/lib/mysql  BUT inside the docker container

Remember, the docker container has its own isolated file system, and any changes with any files, happen WITHIN the container

And then, lets assume, you dump a lot of data into the database, so what happens if you were to delete the mysql container and remove it?

As soon as you do that, the container, along with ALL the data inside of it, gets blown away, meaning all of your data is gone gone

-If you would like to persist data, you would want to MAP a directory (outside the container) from the Docker Host, to a directory inside the container, like a link to the external Host

For example, we will create a local directory to link it to the container in our /opt/ directory, and link it to the container mysql data directory when creating the mysql container, using the -v option for "volume", specifying how both the directories are going to be set up

mkdir /opt/datadir
docker run -v /opt/datadir:/var/lib/mysql

LOCAL DIRECTORY : CONTAINER DIRECTORY

-This way all of the data being worked by that mysql container, will be stored in your local machine at the directory: /opt/datadir

And thus, it will PERSIST, even if you delete that container
