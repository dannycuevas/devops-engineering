# KUBERNETES NETWORKING BASICS

-We will start with a single Node, with IP address:
192.168.1.2

And that will be the address use to access the Kubernetes node,
like SSH into it, etc

-Inside this Node there is a POD, that holds a Container
Unlike in the Docker world where an IP address is assigned to the container,
here in the Kubernetes world, the IP address is assigned to the POD

-EACH POD in the Kubernetes cluster gets its own internal IP address

In this case is in the range:
10.244.x.x series

And the POD IP address is:
10.244.0.2

-So how is the POD getting that IP address?

-When Kubernetes is initially configured, it creates an internal private network
with the address:
10.244.0.0

And ALL the PODS are attached to that internal private network

-When you deploy more separate PODs, they all get a separate IP address,
assigned from that internal network

-The PODs can communicate with each other through this internal network,
but "accessing" other PODs may not be a great idea, as IP addresses may change,
due to being recreated for whatever reason

### Current IP addressing map example

NODE: 192.168.1.2
Internal Network: 10.244.0.0
POD-1: 10.244.0.2
POD-2: 10.244.0.3
POD-3: 10.244.0.4
and so on...


# Cluster Networking

-But how does it work when you have multiple nodes in your cluster?

-Other Nodes hosting their own internal networks with their own PODs,
may also have the same range of IP addresses when they were configured

-That is not going to work when the NODES share the same range of IP addresses,
and want to belong to the same CLUSTER, that will lead to IP conflicts

-When a Kubernetes cluster is set up, Kubernetes does not automatically set up
any kind of networking to avoid these type of issues

-As a matter of fact, Kubernetes will expect us to "set up the networking",
to meet certain fundamental requirements

### Networking Fundamental Requirementes Examples

-All containers or PODs in a Kubernetes cluster must be able to communicate
with each other without having to configure NAT rules

-All NODES must be able to communicate with containers

-All containers must be able to communicate with the NODES in the cluster

-Kubernetes expects us to set up a networking solution that meets those points


### Networking Solutions

-We do not have to set it all up all on our own, as there are multiple
pre-built solutions available

-Some networking solutions are:
    -Cisco ACI Networks
    -Cilium
    -Big Cloud Fabric
    -Flannel
    -VMware NSX
    -Calico

-And so using custom networking, like flannel or Calico, the custom solution
now manages the networks and IPs in the NODES, and assigns a different network
address to for each network in the NODE

-This will create a virtual network of all PODs and NODES where they are all
assigned a UNIQUE IP address

-And by using simple routing techniques, the cluster networking enables the
communication necessary between the different PODs or NODES, so we are able to
meet the networking requirements of Kubernetes

-And so, thus all the PODs can communicate with each other using the assigned
IP address

