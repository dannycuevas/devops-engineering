-Why would you need to create your own image?

-It could either be because you cannot find a "componen" or a "service", that you want to use as part of your application, on DockerHub already
Or
You and your team decided that the application you are developing will Dockerized for ease of shipping and deployment

-In this case, we will containerized an application, a simple web application that was built using the python flask framework


# CREATING AN IMAGE

-We write down the steps required in the right order, for example:

    1-OS Ubuntu
    2-Update the apt repository
    3-install dependencies using apt
    4-install python dependencies using pip
    5-copy source code to /opt directory
    6-run the web server using the "flask" command

Now we can create a DOCKERFILE using those instructions

### First step
-Create a DOCKERFILE with the name dockerfile, and write the instructions for setting up your application like in the example above

    -Including dependencies
    -where to copy the source code from and to
    -what the ENTRY point of the application is


### Second step
-Build your image using the "docker build" command and specify the DOCKERFILE as input as well as a tag name for the image

This will create an Image locally in your system, and to make available on the Public DockerHub registry run the "docker push" command and specify the name of the image you just created, example:

docker build Dockerfile -t danielcuevas/my-flask-app

docker push DOCKER-ACCOUNT:IMAGE-NAME
docker push danielcuevas/my-flask-app


# DOCKERFILE
-Dockerfile is a text file, written in a specific format that Docker can read

-It is in instruction and arguments format, for example:


FROM ubuntu

RUN apt-get update
RUN apt-get install python

RUN pip install flask
RUN pip install flask-mysql

COPY . /opt/source-code

ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run


-In the example above, everything on LEFT in CAPS is an "Instruction" (run, copy, entrypoint)
Each fo those instruc Docker to perform a specific action while creating the image

-Everything on the RIGHT is an "Argument" to those instructions.

For example "FROM ubuntu", this defines what the OS should be for this container, as every docker image must be based off of another image, eaither an OS or another image that was created before, that was based on an OS as well

You can find official releases of OSes on DockerHub

The "RUN" instruction command, instructs Docker to run a particualr given command on those "based images" that we mentioned before
This instruction for example, in our dockerfile above, tells Docker to run "apt-get update" and installs the necessary dependencies on the image

-Then the "COPY" instruction copies files from the local system onto the docker image, in the example above, the source code of our application is in the current folder and we will copy it onto the location "/opt/source-code" inside the docker image

LOCAL-DIRECTORY : IMAGE-DIRECTORY
COPY . /opt/source-code

-And "ENTRYPOINT" allows us to specify a command that will be run when the image is RUN as a Container (the command to start running the actual application)


# LAYERED ARCHITECTURE
-When Docker builds the images, it builds them in a "layered architecture":

Each line of instruction creates a NEW LAYER in the docker image with exactly just the CHANGES compared to the previous layer

### For example:

1-first layer
base ubuntu OS

2-apt-get update and install python packages

3-third layer with python packages like "pip install flask-mysql"

4-fourth layer that copies the source code over onto the docker image

5-final layer that updates the entrypoint of the image (the command to start running the actual application)

-Since each layer only stores the changes from the previous layer, it is reflected in the size as well, as each layer has its OWN size (like in MB mostly)

-You can see this information and the layer sizes in MBs by using the command

docker history IMAGE-NAME
docker history danielcuevas/my-flask-app


# BUILD - CACHED

-All the layers built are "cached" by Docker
-So in case a particular step was to fail, for example:

Step 3 failed, and you wanted to fix this issue by re-running "docker build" command,
then Docker will reuse the previous layers from CACHE and continue to build the remaning layers

-The same is true if you were to ADD additional steps in the Dockerfile

-This way rebuilding your image is faster and you do not have to wait for Docker to rebuild the entire image each time

This is helpful specially, when you update source code of your application as it may change more frequently, as only the layers ABOVE the "updated layers" need to be rebuilt


# What can you containerize?

-We have seen different products containerized, such as:
        -databases
        -development tools
        -operating systems
But you can containerized almost all of the applications out there, including:
        -browsers
        -utilities like curl
        -applications like spotify, skype, etc
        
