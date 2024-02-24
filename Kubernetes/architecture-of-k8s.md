-Basic concepts in a Kubernetes Cluster


# NODES

-A Node is a machine, in which Kubernetes is installed, it can be:
    -physical
    -virtual

-A node is a "WORKER MACHINE", and that is where containers will be launche by Kubernetes

-Node/Worker machines were also known as Minions in the past,
but you can use either term as you like

-But what if the need in which your application is running fails?
The application goes down, so you will need to have more than 1 Node ready


# CLUSTER

-It is a set of nodes grouped together

-This way, if one node fails, you have your application still accessible from the other running nodes

-Also, having multiple nodes, helps in sharing the loads as well

-Who is responsible for managing the cluster?
where is the information about the members of this cluster stored at?
how are the nodes monitored?

When a node fails, how do you move the workload of the failed node to ANOTHER worker-node?

This is where the MASTER comes in


### MASTER NODE
-The MASTER is another node, with Kubernetes installed in it,
and is CONFIGURED as the master

-The MASTER watches over the nodes in the cluster,
and is responsible for the actual Orchestration of containers (containers that now head over to the worker noders)


# KUBERNETES COMPONENTS

-When you install Kubernetes on a system, you are actually installing the following:

    -API server
    -etcd service
    -kubelet service
    -container runtime
    -controllers
    -schedulers

### API server
-Acts as the frontend for Kubernetes

-The users, management devices, command line interfaces,
ALL talk to the API server to interact with the Kubernetes Cluster

### etcd Key Store
-It is a distributed reliable "key-value store" used by Kubernetes to store all data used to managed the cluster

-Think of it this way,
When you have multiple nodes, and multiple masters in your cluster,
then "etcd" stores all of that information ON all the nodes in the cluster in a distributed manner

-etcd i responsible for implementing LOGS within the cluster, to ensure that ther are no conflicts between the masters

### Scheduler
-Is responsible for "distributing work", or containers, across multiple nodes

-It looks for newly created containers and assigns them to nodes

### Controllers
-Controllers are the brain behind Orchestration, also known as "Control Manager"

-They are responsible for noticing and responding when
nodes
containers
or endpoints
go down

The controllers make decisions to bring up new containers in such cases

### Container Runtime
-This is the underlying software that is used to run the containers

-In our case, this would be Docker

### Kubelet
-This is the AGENT that runs on EACH node in the cluster

-The Agent is responsible for making sure that the containers are running on the nodes as EXPECTED



# MASTER VS WORKER NODES

-After seen all of the architecture components,
how are they distributed across the different types of nodes?

How does one node BECOME the master and the other the worker?

-The Worker/Minon node, is where the containers are hosted

-And to run docker containers on a system, we need Container Runtime installed, so this is where the Container Runtime falls into (in out case, this is Docker)

-Worker Nodes also have the "KUBELETE Agent", that is responsible for interacting with the MASTER:
to provide HEALTH information of the worker node
and carry out "Actions" requested by the master node


### Master Server
-So then the master server has the "KUBE API Server" and this is what makes this node the "master server"

-Like we have seen before, ALL INFORMATION is gathered and stored in a "key-value store" on the MASTER node, which is the ETCD / etcd key store

-The master also has the "control manager" and the "scheduler"



# kubectl - command line utility

-The kubectl is used to deploy and manage application on a Kubernetes cluster,
to get the cluster information,
to get the status of other nodes in the cluster,
and to manage may other things

-Deploy an application on the Kluster
kubectl run hello-minikube

-View information about the cluster
kubectl cluster-info

-List all the nodes part of the cluster
kubectl get nodes

