# DOCKER NETWORKING

-When you install Docker, it will create 3 networks automatically:
    -bridge
    -null/none
    -host

-Bridge, is the default network a container gets attached to

If you would like to associate the container with a different network, you specify the network information using the --network option

docker run ubuntu --network=host
docker run ubuntu --network=none

### Bridge Network
-This is a private internal network created by Docker on the HOST

-All containers WILL be attached to this network by default,
and they get an INTERNAL IP address, usually in the range:

172.17 series

-And so the containers can access each other by using this internal IP if needed

-Now, to access any of this containers from the OUTSIDE world, map the ports of these containers to ports on the HOST, just as we have seen before

HOST-PORT : CONTAINER-PORT

### Host Network

-Another way to access the containers externally is to associate the container to the HOST own network

-This will take out any network isolation between the HOST and the containers,
Meaning;
If you were to run a web server on port 5000 in a web app container, it is automatically as accessible on the same port externally, without requiring any port mapping, as the web container uses the HOST own network

-This would also mean, that unlike before;
You will now not be able to run multiple web containers on the same HOST, on the same port, as the ports are now common to all containers in the HOST own network

### None Network

-With the None Network, the containers are not attached to any network,
and it does not have any access to the external network or OTHER containers

-The containers here are run in an isolated network


# BRIDGE NETWORKING

-What if we want more than the 1 default Bridge network on our Docker HOST?

-We could create our own internal network, using the command "docker network create" and specify the driver (type of network, which is bridge in this case), and the subnet for that network, followed by the custom name for the new network

docker network create \
--driver bridge \
--subnet 182.18.0.0/16 isolated-network

-And then you can list all your networks with the following command

docker network ls

-Other examples:

docker network create --driver bridge --subnet 182.18.0.1/24 --gateway 182.18.0.1 wp-mysql-network

nspect the created network by

docker network inspect wp-mysql-network


# INSPECT NETWORKS

-How do we see the network settings and the IP address assigned to an existing network?

-To inspect the metadata of a network we use "docker inspect" command with the ID or name of the container, and search for a section called "Network Settings", and then "Networks" to see what type of network it is and its "IPAddress"

docker inspect blissful_hopper


# EMBEDDED DNS Server

-Containers can reach other using their NAMES

-How can I get my web server to access the database on the database container?
(given they are on the same bridge network)

-One thing we could do, is use the internal IP address assigned to the container,
but this is not IDEAL, because it does not guarantee that the container will get the same IP address when for example the system reboots

-And so, the right way to do it, to communicate one container to another,
is to use the container NAME

-ALL containers in a Docker HOST can resolve each other with the NAME of each other

-Docker has a "built-in DNS SERVER" that helps the containers with this task of resolving each other by using just their container names

NOTE: this DNS server always runs at the IP address of 127.0.0.11

-So how does Docker implement networking?
How are the containers isolated in their own network within the HOST machine?

-Docker uses "Network Namespaces" that creates a "separate namespace" for EACH container, and it then uses virtual ethernet pairs to connect containers together
