# DOCKER STORAGE AND FILESYSTEM

-How Docker stores data on the local filesystem?

-When you install Docker on a system, it creates a directory structure at:

/var/lib/docker

And you have multiple folders under it called:
    -aufs
    -containers
    -image
    -volume
    -etc
And this is where Docker stores all of its data by default,
And when we say data, we mean files related to images and containers running on the Docker HOST

-For example, all files related to containers are stored under the "containers" folder, and the files related to Images are stored under the "images" folder

-Any Volumes dreated by Docker containers are created under the "volumes" folder

-So how does Docker stores the files of an Image and the files of a Container?
To understand that, we need to understand "dockers layered architecture"


# LAYERED ARCHITECTURE

-Remember, when Docker builds images, it builds images in a "layered architecture"

-Each line of instruction in the DOCKERFILE creates a "new layer" in the docker image with just exactly those changes from the previous layer, example:

    layer1- base ubuntu layer
    layer2- changes/updates in apt packages
    layer3- changes/updates in python/pip packages
    layer3- source code
    layer5- udpate the entrypoint


-To understand the advantages of this "layered architecture", lets consider a Second Application, called DOCKERFILE-2, so it is a different dockerfile

-This new dockerfile is still similar to the original Dockerfile, as in it uses the same base image as ubuntu, uses python and flask dependencies (so similar application), but uses a different SOURCE CODE to create a different application, and so a different ENTRYPOINT as well

-So when we run the "docker build" command to build this new image for this new application, since the first 3 LAYERS of both the applications are the SAME, docker does not need to BUILD the first 3 layers

-Instead of rebuilding those first 3 layers, it reuses the existing same 3 layers it built for the FIRST dockerfile, from cache, and only creates the last 2 layers with the new SOURCE CODE and the new ENTRYPOINT

-This way, Docker build images faster and efficiently, and also saves disk space

-This is also applicable if you were to update your application code
Whenever you update your application code, such as your main file with the actual code (for example the "app.py" that copies from your HOST directory into the containers /op/source-code directory), Docker simply reuses all the previous layers from cache and quickly rebuilds the application image by updating the latest source code

Thus saving us a lot of time during rebuilds and updates

-All of these layers are created when we run the "docker build" command to form the final docker image

-Once the build is complete, you cannot modify the existing contents of these layers, as they will now be READ-ONLY, and you can ONLY modiify them by initiating a new build

### Container Layer

-When you run a container based off of this new image using the "docker run" command, Docker will create a new container based off of those layers and creates a new writable layer at the top of the image layer

-The writable layer is used to store data created by the container such as:
log files wirtten by the applications
any temporary files generated by the container
or just any file modified by the user on that container

-The life of this layer, it is alive only as long as the container is alive,
when the container is destroyed, this layer and all of the changes stored in it are also destroyed

-Remember that the same image layer is SHARED by all containers created that use this SAME image


# VOLUMES AND PERSISTING DATA

-What if we want to persist the data of a container after deleting it?
-For example, if we were working on a database and we would like to preserve the data created by the container, we could use a "persistent volume" to the container

-To do this, first create a "volume" using the "docker volume create" command:

docker volume create VOLUME-NAME
docker volume create data_volume

-This creates a folder called "data_volume" under the HOST directory:

/var/lib/docker/volumes/data_volume

-Then when we run a new container, we can mount this volume inside the new docker container "read-write" layer (the top layer) using the -v option, example:

docker run -v data_volume:/var/lib/mysql mysql

HOST-VOLUME : CONTAINER-VOLUME
data_volume:/var/lib/mysql

-This will create a new container and mount the data volume (that we created on our host) into the container folder "/var/lib/mysql"

So ALL data written by that mysql database inside the container is in fact going to be stored in the volume created on our HOST, which will be at "/var/lib/docker/volumes/data_volume"

-And so, even if the container is destroyed, the data will still REMAIN

-If you did not created the new volume before creating a new container to attach it to the "docker run command", then docker will create it for you automatically, based on the name given at the "docker run" command, example:

docker run -v data_volume2:/var/lib/mysql mysql 

-This all si called "VOLUME MOUNTING"

### Bind Mounting

-Now, we can also attach a volume from a different location that is not our HOST directory /var/lib/docker/volumes/new-volume

-Example, if we had something on our HOST like "/big-data/my-data/", we mount it as:

docker run -v /big-data/my-data:/var/lib/mysql mysql

-And since we are mounting from a different location to the default, this is called:
"BIND MOUNTING"


# The option --mount

-For all the mentioned commands, using the "-v" option is the old way of doing things

-The new and current way is to use "-mount" option

-This is the preferred way as it is more "verbose"

-Example of the more verbose way:

docker run \
--mount type=bind,source=/big-data/my-data,target=/var/lib/mysql mysql

-Type "bind", because is not from the default volume directory
-Source is the path location on my HOST
-Target will be the path location on the container


# DRIVERS

-So who is responsible for doing all these operations?
    -maintaining the layered architecture
    -creating a writable layer
    -moving files across the layers

-It is the Storage Drivers

-Docker uses Storage Drivers to enable layered architecture, and each storage driver offers different functionality and characteristics

-Common Storage Drivers:
    AUFS
    ZFS
    BTRFS
    device mapper
    overlay
    overlay2

-The selection fo the storage driver depends on the underlying OS being used, for example Ubuntu, the default storage driver is AUFS, whereas this storage driver is not available on other operating systems like Fedora or CentOS

-Docker will CHOOSE the best storage driver available automatically based on the operating system