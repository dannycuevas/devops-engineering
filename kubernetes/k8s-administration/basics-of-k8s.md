# Control Plane (Core Components)

The control plane of the Kubernetes cluster is responsible for managing the cluster and making decisions about scheduling, scaling, and maintaining the desired state of the applications.

The master node consists of several key components:

Kube ApiServer:

    The API server is the front end for the Kubernetes control plane. It exposes the Kubernetes API, which is used by users, administrators, and other components to interact with the cluster.

    The API server validates and processes requests, and then stores the state of the cluster in the etcd datastore.

Etcd:

    Etcd is a distributed key-value store that serves as the database for the Kubernetes cluster. It stores the configuration data, state, and metadata of the cluster.

    Stores the entire state of the cluster, including configuration, state, and metadata, essentially the entire state of the cluster.

Kube Scheduler:

    The kube scheduler assigns unscheduled Pods to worker nodes based on resource needs, policies, and constraints.

    It considers factors like CPU, memory, node availability, taints, affinities, and other scheduling rules.

Kube Controller Manager:

    The kube controller manager runs core controllers that ensure the cluster matches the desired state by monitoring and reconciling resources.

    It manages tasks like node health and the following controllers

        NodeController: Manages node health and status

        ReplicationController: Ensures the desired number of pod replicas

        EndpointsController: Manages service endpoints for discovery

        NamespaceController: Handles namespace lifecycle

        ServiceAccountController: Manages default service accounts

        JobController: Manages batch jobs

Cloud Controller Manager:

    The Cloud Controller Manager integrates Kubernetes with cloud providers (e.g., AWS, GCP, Azure) to manage external cloud resources.

    It handles cloud-specific logic such as provisioning load balancers, attaching storage volumes, and managing network interfaces.

# Worker Plane

The Worker Plane consists of nodes that run your actual containerized applications.
Each worker node hosts essential components like the kubelet, kube-proxy, and a container runtime. These nodes execute workloads, maintain network rules, and report status back to the control plane with the help of kubelet.

Kubelet:

    Kubelet is the primary agent on each worker node that communicates with the control plane to ensure that Pods are running as defined in their specifications.

    It manages the lifecycle of containers, starting, stopping, and monitoring their health, and reports the node and Pod status back to the control plane.

Kube Proxy:

    Kube proxy is a network proxy running on each worker node that manages network rules and facilitates communication within and outside the cluster.

    It implements the Kubernetes Service abstraction by forwarding traffic to the correct Pods based on IP and port mappings.

Container Runtime:

    Container Runtime is the software responsible for running containers on each worker node (e.g: Docker, containerd, CRI-O).

    It works with the kubelet to start, stop, and manage the lifecycle of containers as defined by Kubernetes.
