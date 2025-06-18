# DEPLOYING VOTING APP ON KUBERNETES

### Goals:

1- deployo containers
2- enable connectivity between the containers
3- enable external access for the external-facing app, which are the voting and
the result app

-Remember we cannot deploy containers using kubernetes because the smallest
object we can create on a kubernetes cluster is a POD

-So we must first deploy our applications as PODs in our kubernetes cluster, or
we can also deploy them as replica sets, or deployments, as we have seen before


### Deploying the Infrastructure

-So once the PODs are deployed, the next step is to enable connectivity between
the SERVICES (in this case, the containers inside the PODs)

-Remember is important to know what the CONNECTIVITY requirements are, so we must be very clear about what application requires ACCESS to what services

-We know that the REDIS database is accessed by the voting-app and the worker
app, the voting-app saves the vote to the REDIS database, and the worker app reads the vote from the redis database

-We know that the POSTGRESQL is accessed by the worker app to update it with the
total count of votes (from the voting-app), and is also accessed by the 
result-app to read the total count of votes from postgresql, so thy can be
displayed in the "resulting" web page in their browser

-So we know that the voting-app is accessed by the external users (the voters),
and the result-app is also accessed by the external users ti view the results

-And so, must of the components are being accessed by another component, except
for the worker app, note that the worker app is NOT BEING accessed by anyone

The worker app simply reads the count of votes from the redis database, AND THEN
updates the total count of votes on the postgresql database


-Now, how do you make one component accessible by another?

For example, how do you make the redis database accessible by the voting app?
and so the RIGHT way to do it, is use a SERVICE

-We learn that a service can be used to espose an application to another app or
users for external access

So we will create a service for the redis pod so that it can be accessed by the
voting app and the worker app, and we will call it:
redis service

And it will be accessible anywhere between the cluster, by the name of the actual
service "redis"

-And then the service that we will create for the postgresql will be called just:
"db"

These will be the names as they are hard-coded in the source code of the apps,
and also, these services are not meant to be accessed from outside the cluster


-The next task is to enable EXTERNAL ACCESS
For this we can use a service with the type set to "NODE PORT"

-So we create services for the apps facing out, the voting app and the result app
using NodePort services, to allow that communication with the outside


### To Summarize

-We will deploy 5 PODs in total

-We will have 4 services;
1 for redis, 1 for postgresql / cluster IP services
2 for external facing services, voting app and result app

-And no service for the worker pod, as it is not being accessed by another app or
another external user, it is just a worker process 

-A service is only REQUIRED if the given application has some kind of process
or database, or anything, that needs to be "exposed", that needs to be accessed
by others 


