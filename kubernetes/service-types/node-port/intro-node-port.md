# NODE PORT - SERVICE

-A Kubernetes Service is an OBEJCT, just like PODs or Replica Sets or
Deployments

One if its use-case is to LISTEN to a PORT on the NODE, and forward requests
on that PORT to another port on the POD that is running the web app CONTAINER

-This type of service is known as a NODE PORT SERVICE
Because the service listens to a PORT on the NODE, and forward those requests
to the PODS

Requests to NODE-port > goes to NODE-port > goes to APPLICATION-container

-The service makes an internal POD accessible on a PORT of the NODE
Mapping a PORT on the NODE, to a PORT on the POD that hosts the webapp container


### There will be 3 PORTs involded:

-TARGET
The port on the POD where the actual web-server is running
Named "target" because that is where the service forwards the request to
Port 80

-SERVICE PORT
Second port is the port on the service itself
It is simply referred to as the "port"
The service is in fact, like a Virtual Server inside the NODE

And being inside the cluster it has its own IP address, and that IP address
is called "cluster IP of the service"
IP address and port: 10.106.1.12 : 80

-NODE PORT
This is the port on the hosting NODE, which we use to access the web-server
externally, known as the NODE PORT
Port 30008

This is because NODE ports can only be in a "valid range", which by default,
can go from 30000 to 32767

-These terms are from the VIEWPOINT of the SERVICE


### Create the Service

-Just like other objects, we will use a YAML definition file, using the common
high level structure we have used before

-And "SPEC" will be the most crucial part of the file, as this is where we will
be defining the actual services

apiVersion: v1
kind: Service
metadata:
    name: nodeport-serv

spec:
    type: NodePort
    ports:
      - targetPort: 80
        port: 80
        nodePort: 30008


-Under "spec" then, the type refers tot he type of service we are defining

-And "ports:" is where we enter information regarding the 3 ports involved
    -first port is TargetPort
    -second port is the port on the service object
    -third port is the NODE port, that can go from 30000 to 32767
    -note that "ports:" is an array

-If you do not provide a target port it will assume to use the same one as "port", so the same as the service port

-If you do not provide a NODE PORT, a free port within the valid range is automatically allocated


### Link the Service to specific PODs

-This will requirea technique that we will see very often in Kubernetes,
we will use LABELS and SELECTORS to link them together

-We know the PODs were created with a LABEL, and we need to bring that label
into the SERVICE definition file

This will be done using a property called "selector:" inside the "spec:" of
the SERVICE definition YAML file

And under the "selector" provide a list of labels to identify the PODs that need
to be linked with the service

apiVersion: v1
kind: Service
metadata:
    name: nodeport-serv

spec:
    type: NodePort
    ports:
      - targetPort: 80
        port: 80
        nodePort: 30008

    selector:
        app: myapp
        type: front-end


-We will be getting the LABELS from the definintion YAML file that we used to
create the PODs that need to be linked, these labels would be the ones under the
"labels" key value, under "metadata", under the "templade" of the PODs


### Multiple NODES running

-Kubernetes will create the new SERVICE to spawn ACROSS all nodes without you
having to do any extra configuration

-And it will take into account, just like before, the PORTS mentioned in your
definition YAML file, to filter and redirect traffic to the PODs in all the NODES

-The SERVICE will search for all the PODs matching the LABELS specified in your
definition YAML file, across all the NODES, and link them to the service as
ENDPOINTS to forward the external requests from the users

-When PODs are removed or added, anywhere in any NODEM (for the ones matching the
labels), the SERVICE is automatically "updated", making it highly flexible


### Traffic Balancing Algorithm

-What algorithm is used to balance the load across all the PODs linked?

It uses a RANDOM algorithm

-Thus the service acts as a built in load balancer to distribute load across
all the different linked PODs


