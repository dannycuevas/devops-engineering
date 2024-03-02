# Intro to Microservices


### Sample Application

-We have an example application, which is a voting application, ans this app
consists of variius components, such as:
    -voting app / python
    -in-memory DB / redis
    -worker node / .net
    -database / postgresql
    -result-app / nodejs

-Voringapp web application, developed in python, to provide the user with an
interface to choose between the 2 options; option 1 cat and option 2 dog

-When you make a selection, that vote is stored in redis, which serves as a
database in memory

-The vote is then processed by the worker, which is an application written in
.net language

-The worker application takes the new bote and updates it in the persistent
database, in this case the postgresql

-The postgresql simply has a table with the number of votes for each category, which was cats and dogs

-Finally, the result of the vote is deplayed in a web interface, which is another
whici is another web application, but this time developed in nodejs

-This resulting application reads the count of votes from the postgresql database
and displays the final results to the user

-And so, that is the ARCHITECTURE and DATA FLOW of this simple voting application
stack


### Enter Microservices

-And so, as you can see, this sample application is built with a combinationn of
different services, also different development tools, and multiple different
development platforms such as python, nodejs, .net

-Thus, making us able to put together this application stack on a single Docker
ENGINE using docker run commands

-And naming the containers is also important, we will discuss it next

docker run -d --name=redis redis

docker run -d --name=db postgresql:9.4

-Next, since this is a web server, it has a web UI instance running on port 80
we will publish that port to 5000 on the host system, so we can access it from
a browser

docker run -d --name=vote -p 5000:80 voting-app

-Next, we will deploy the results web application that shows the results to the
user, we deploy the container and publish the container port 80 to port 5001 on
the host machine

This way we will be able to access the web UI of the "resultin" application on
the browser

docker run -d --name=result -p 5001:80 result-app

-Finally we deploy the worker by deploying an instance of the worker image

docker run -d --name=worker worker


-Now, all containers are running on the host just fine, but the whole application
is not working as expected, this is because we have not LINKED the containers
together


### LINKS

-So how do we link the containers together?
We use LINKS

-"Link" is a command line option, which can be used to link containers together

-So we add the link option while running the "voting app" container to link it to
the "redis" container, by specifying the name of the redis container, followed
by a colon, and the name of the host that the voting app is looking for, which is
also redis in this case

docker run -d --name==vote -p 5000:80 --link redis:redis voting-app

Now, this is why we NAMED the containers when we eun them the first time, so we
could use their simple names when creating a link

-What is the link actually doing?
It creates an "entry" into the /etc/hosts file on the voting app container,
adding an entry with he hostname "redis" wit the internal IP address of the redis
container

-Also, we add a link for the "result app" to communicate with the database by
adding a link option to refer to a database by the name "db"

docker run -d --name=result -p 5001:80 --link db:db result-app

-Finally,
the worker application requires access to both the redis as well as the database
postgresql
so we will add 2 links to the worker application, one link to link the redis, and
the other link to link the postgresql database

docker run -d --name=worker --link db:db --link redis:redis worker

-Note that using links this way is deprecated, and the support may be removed in
the future of Docker

Because there are better ways of achieving all of what we just did with "links",
but this is worth mentioning to be able to learn all the necessary basics of the
concepts


