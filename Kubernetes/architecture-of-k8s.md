
### Kubernetes Cluster
- A cluster is compose of 2 resources:
	- Master Node / Control Plane
	- Worker Nose
- Application in a Docker Container gets deployed to a Worker node
- Each Worker Node has a Kubelet


## Control Plane / Master Node

1. **API Server**:        
	- The entry point to the control plane. It's like the "front desk" where all requests to manage the cluster go. Meaning, **this is the main management component**
	- This component exposes the Kubernetes API, allowing you to interact with the cluster using `kubectl` or other tools. 
	- It authorizes requests, but first it validates and processes the requests, then updates the cluster's state.
	- Also, it orchestrates the communication between the other control plane components, and is the "point of contact" for all the other control plane components as well as for some from the worker node (like "kubelet" and "kube proxy")
- 
1. **etcd**:        
	- A distributed key-value store that serves as the central database for Kubernetes
	- **etcd stores the current state of the cluster** (also, any information that you get when you run `kubectl get` is from etcd)
	- It stores all the cluster's configuration and state information, like **the current state of pods, deployments, services, and more.** This is the "source of truth" for the entire cluster
	- Anything that changes in the cluster or creates resources like nodes, pods, secretes, and so on, will need to be or will be updated in the "etcd server"
- 
3. **Controller Manager**:        
	- Keeps track of what is happening inside of a Kubernetes Cluster
	- It is listening to the Worker Nodes and their health, so if a Node crashes, it will bring up a Node as soon as possible
	- **It watches the current state of each object through the API server, fetches information from etcd or kubelet (depending on the situation) and compares it with the "desired state"**, if the states do not match, the associated controller manager will take action
		- for example, the "node controller" watches the state of the nodes
		- another example is the "replication controller", which makes sure that the desired number of pods exist 
	- For example, there's a controller for managing deployments, another for maintaining the desired number of replicas, and others for handling node failures or coordinating scaling. This component ensures the cluster maintains its desired state.
		1. Replication Controller
		2. ReplicaSet Controller
		3. Deployment Controller
		4. StatefulSet Controller
		5. DaemonSet Controller
		6. Job Controller
		7. CronJob Controller
		8. Service Controller
		9. Node Controller
		10. Service Account & Token Controllers
		11. Endpoint Controller
- 
2. **Scheduler**:    
    - Decides where to place new pods on the cluster's Worker Nodes
	    - The Scheduler watches the API server for new pods for which it will try to find the proper node
    - It makes decisions and considers multiple factors like container's resource requirements, node size, affinity rules, and other constraints (like taints, toleration, selectors, etc) to ensure workloads are efficiently distributed across the cluster
    - So it will try to find the best suitable Node int the cluster for all Pods


## Worker Node

#### Kubelet
- Kubelet is an agent that runs on each worker node in the cluster
- Kubelet receives the instructions from the Control Plane, to be executed in its particular worker node
- So it is the component that communicates with the control plane via the API Server, to also see if there are any new state changes scheduled on the worker nodes
- Basically, it makes sure that the "desired state" defined in the pods is reflected in the actual state of the system
- The kubelet monitors the worker node to make sure that the Containers that are running on it are healthy and running
	- so it also communicates with the "Container runtime" to start or stop the containers 

#### kube-proxy
- When we define what a cluster is, all the nodes in the cluster are grouped together in a shared network
- **kube-proxy is a "network proxy" that runs on each node and is in charge of maintaining network rules on the worker nodes, and to handle network traffic and routing and load balancing (on a "node level")** for;
	- local cluster network traffic
	- as well as external network traffic
	- although, it is most recommended to expose pods using a kubernetes service 
- It configures the the `iptables` rules on each node to forward traffic to the pods exposed by kubernetes services (kube proxy obtains that information directly from the API server)
	- Each node has a unique IP address, and it is maintained by the kube-proxy
- kube-proxy also helps monitor the pods and services running on the nodes by updating the local IP tables and firewall rules
	- so if a pod is unavailable, the node's routing information knows where and where not to send traffic to

#### Container Runtime
- This is the software installed on every worker node that actually runs the containers, whether they are Linux or Windows 
- AKS default is containerd (it used to be Docker in the past) 
- The container runtime communicates with the Kubelet, and fetches the container images, and is also responsible for starting and stopping containers 


## Kubernetes Objects

- Objects come into play when working with "configuration files" for the cluster
- All of these "objects" are configured in a `yaml` configuration file

### Pod
- The smallest 1-unit of a deployable component in Kubernetes
- Pod can contain 1 or more containers, when they hole more than 1 is because mainly they need to share the same "Lifecycle", or "share resources" like storage and networking
	- This can even include, moving a pod, that is hosting multiple containers together, to another nod 
- When a Pod gets created it gets an IP address assigned, but if something happens to it and it goes down or deleted, the new Pod will also get a NEW IP address
	- Hence why we use "Services" to expose our applications/containers
- **Containers Storage** - within the same pod can share the same storage, allowing them to exchange data, logs, or other files. This shared storage is defined through the use of Kubernetes volumes.
	- **Volume**: A volume in Kubernetes is a piece of storage accessible to containers within a pod. You can define various types of volumes depending on your storage needs, such as `emptyDir`, persistentVolumeClaim, configMap, secret, and more.
	- **Sharing Storage Within a Pod**: When you define a volume at the pod level, all containers within that pod can mount and share the same volume. This setup allows them to read and write data to a common location.

### DaemonSet
- Type of "controller" that ensures a specific pod runs on every node in a Kubernetes cluster. It's a way to guarantee that a certain type of application or service is consistently deployed across all nodes.
- Useful for tasks that require monitoring, logging, monitoring agents, security, or other system-level functions
- A demonset makes sure that only 1 instance of the specific pod runs on each node, and they will automatically replaced if they stop working

### Service
- **A Kubernetes Service is an object that provides a stable network "endpoint" to expose a grouping of Pods through a single IP address**
- Services provide access to Pods from internal applications, or from external users
- Is an abstraction that represents a logical set of Pods and defines how these Pods should be accessed, either **internally** within the cluster or **externally** from outside the cluster
	- 
	- #### Example 1: Load Balancer Service
	- Suppose you have a deployment running multiple replicas of a web application. You want external clients to be able to access this application through a single IP address or DNS name, with traffic automatically distributed across all replicas
	- 
	- #### Example 2: ClusterIP Service
	- Let's say you have a set of backend Pods providing a REST API or a microservice that other services within the Kubernetes cluster need to access. You don't want this Service to be accessible from outside the cluster, only within.
	
- All services available for using in Kubernetes
	- ClusterIP
	- NodePort
	- LoadBalancer
	- ExternalName
	- Headless Service

### Deployment
- A "deployment" declares what the desired state of the Pods should be, this way you can create or update multiple pods from the same file
- A "deployment" provides declarative updates for Pods and ReplicaSets
- A deployment is also involved with scaling and auto-scaling your application
- You can define deployments to create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments

### Replica Set
- They guarantee that there will be a specific number of identical Pods running at all times
- You get to enforce a minimum number of Pods for your application (deployment) to be running
- Meaning, typically the Deployments will manage the Replica Sets 

### Secret
- This is a kubernetes resource that allows you to store sensitive information such as;
	- passwords
	- API keys
	- certificates
	- all in a secure and reliable manner 
- The main use of a Secret is to securely store sensitive information that is required by pods or other components in the cluster 
- For example, to store a database password that a pod needs to access a database, or, to store an API key that a pod needs to access a third-party API 

### ConfigMap 
- It is a resources that stores configuration information as key-value pairs 
- Pods and other cluster components can use the information contained in a configmap to dynamically configure themselves at runtime 
- Environment variables and configuration files are examples of non-sensitive configuration data that can be stored in configmaps  

### Namespace
- Use to allocate cluster resources to multiple users or teams
- Also use to divide multiple environments, projects, or applications 
- It will allow you to isolate resources within the same cluster 
- For example, you can have a testing team and a development team using the same cluster and you can use namespaces to isolate them from each other 
