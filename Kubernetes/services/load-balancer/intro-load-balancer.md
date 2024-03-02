# INTRO TO LOAD BALANCER

-We know that the service type NODE-PORT can help in receiving incoming traffic
requests on the PORTs of the NODES, and then routing that traffic to the
respective PODs

But what URL woudl you give your end users to access the applications?

-You could access any of the applications inside the NODES using the IP address
of any of the NODES and their configured PORT in which the services is "exposed
on"

-But this is not what the end users want, they need a single URL like:
examplevoting.com, or exampleresult.com


### Kubernetes Load Balancer

-If we were in a supported cloud platform, like GCP, or Azure, we could leverage
the NATIVE Load Balancer of that cloud platform

-Kubernetes has support for integrating with the native Load Balancer of your
cloud provider, and helping us configuring that for us


### Creating the Load Balancer

-Same as the other objects, we just create the definition YAML file, with the
same default structure as the other services:
    apiVersion:
    kind:
    metadata:
    spec:

-And we edit the file for the Load Balancer type

apiVersion: v1
kind: Service
metadata: myapp-service

spec:
    type: LoadBalancer
    ports:
      - targetPort: 80
        port: 80
        nodePort: 30008

