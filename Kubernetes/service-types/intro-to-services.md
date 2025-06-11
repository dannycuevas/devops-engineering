# KUBERNETES SERVICES


### What are Kubernetes Services?
-Kubernets Services enable communication between vrious "components",
within and outside of the application 

-Kubernetes Services help us "connect applications" together, and with other
applications or users

-Services can enable the "front-end" application to be made available to users

Then services will also help with the communication between backend and front end
pods, and helps in establishing connectivity to an external data source

-Thus, services enable "losse coupling" between MICROSERVICES in our application


### Example Scenario using Services

-How do you access the web server app in a POD, that is in its dedicated internal network, that is inside of a NODE (a Node with its own IP address), from your laptop?

-The NODE can communicate to the PODs within it, but no other sources can
communicate directly to the PODs inside a NODE, nor PODs can communicate to
external sourcers outside the hosting NODE

-We need something in the MIDDLE to helps map requests, to the hosting NODE from our laptop, to make the request go through the NODE and get to the POD and get to the web app CONTAINER

-This is where the Kubernetes SERVICE comes into play

-And a Kubernetes Service is an OBEJCT, just like PODs or Replica Sets or
Deployments

One if its use-case is to LISTEN to a PORT on the NODE, and forward requests
on that PORT to another port on the POD that is running the web app CONTAINER

-This type of service is known as a NODE PORT SERVICE
