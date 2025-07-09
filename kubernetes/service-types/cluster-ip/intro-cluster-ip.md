# INTRO TO CLUSTER IP

-A full-stack web application typically has different kinds of PODs hosting
different parts of an application

-Example, you may have a number of PODs running the:
    -front end server
    -back end server
    -running a key value store like redis
    -and another set of PODs running a persistent database like mysql

-And so, the frontend needs to communicate to the backend, and the backend needs
to communicate to the databases as well as the redis service

-What is the right way to establish connectivity between these services/tiers
of the application?

All the PODs have their own unique IP addresses assigned, but we know that PODs
can go down at any time and new PODs will need to be created, and those new ones
will get different IP addresses

So you cannot rely on any of these IP addresses for internal communication
between the application


### Enter the ClusterIP

-A Kubernetes Service can help us group the PODs together and provide a single
interface to access the PODs in a tier/group

-For example, a service created for the Backend PODs will help group all the
Backend PODs together and provide a SINGLE INTERFACE for other objects, like the
Frontend tier/group, to access this entire tier/group

-The request are forwarded to one of the PODs under the service AT RANDOM

-Thid enables us to easily and effectively deploy a "microservices -based
application" on a Kubernetes cluster

-Each LAYER (tier/group of PODs) can now SCALE or move as required, without
impacting communication between the various services

-Each service gets an IP and a name assigned inside the cluster, and that is the
NAME that should be used by other PODs to access the service

-This type of service is known as ClusterIP


Create a ClusterIP

-Same as other objects, we use a definition YAML file to create a ClusterIP,
using the default template:
    apiVersion:
    kind:
    metadata:
    spec:

-Example definition YAML file:

apiVersion: v1
kind: Service
metadata:
    name: back-end


spec:
    type: ClusterIP
    ports:
      - targetPort: 80
        port: 80
    selector:
      app: myapp
      type: back-end


-The "targetPort" is where the backend is exposed, in this case 80, and the
"port" is where the SERVICE is exposed, in this case 80 as well

-To LINK the Service to a set of PODs, we use the "selector", and get the values,
like in the other objects, from a POD definition file and copy the "labels" from
the "metadata" information, and paste the labels under our ClusterIP "selector"
section

-Once the service is created, the service can be ACCESSED by other PODs using the
"cluster ip" -IP address, or the "service-name" (kubectl get services)


