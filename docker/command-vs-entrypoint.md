-Unlinke virtual machines, containers are not meant to host operating systems.

-Containers are meant to run specific tasks or processes, such as to host an instance of a web server, or application server, or a database, or simply to carry out some kind of computation or analysis

-Once that said task is "complete", the container exits, a container only lives as long as the process inside ir is alive

-If the web server inside the container is stopped, or chrashes, the container exits


# PERMANENT NEW STARTING POINT

-So who defines what process is run within the container?
How do you specify a different command to start at the run of a container?

-One option, is to append the command to the "docker run" command, and that way it overriders the "default command" specifified in an Image, example:

docker run ubuntu sleep 200

This way, when the container starts, my sleep command will start as well

-But how do you make that change permanent?
Say, you want that image, to always run the sleep command when it is started 

You would then create your OWN Image, from that base ubuntu image, and SPECIFY the new command to be run in each new container run

-There are different ways to add that command:

    -Enter the command simply as is, in a shell form

CMD ["command","param1"]

    -In a JSON array format
    
CMD ["sleep","5"]

But remember, when using the JSON array format, the FIRST element of that array should be the executable (command name), example, the "sleep" command, just do not specify the command and parameters together without symbols or commas, example of a good command is this:

CMDS ["sleep","5"]

-Now, since this command option, is hardcoded into the Image, what if I wish to change the number of seconds it sleeps?, currently it is hardcoded to 5 seconds

One option, is to run the "docker run" command with the NEW command appended to it, example in this case, with 100 seconds:

docker run ubuntu-sleeper sleep 100

And so the command that will be run at startup will be "sleep 100" or you can just pass the new number of seconds as a parameter, as the actual command should be invoked automatically, so we are just passing the "parameter", example with 1000 seconds:

docker run ubuntu-sleeper 1000


# ENTRYPOINT

-And that is where the "entrpoint" instruction of your DOCKERFILE comes into play

-The entrypoint instruction is like the command instruction, as you can specify the program that will executed once the new container starts, example:

ENTRPOINT ["sleep"]

And whatever you specify on the command line parameter, will get appended to the entrypoint

docker run ubuntu-sleeper 10
