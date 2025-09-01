## What happens when you deploy a pod in a Cluster?

- The master and worker nodes work together to form a functional Kubernetes cluster.
- Users interact with the cluster through the kubectl command-line tool, which communicates with the kube-apiserver.
- The API server validates and processes requests, and then stores the state of the cluster in etcd.
- The scheduler then schedules pods onto worker nodes, and the kubelets on those nodes start and manage the containers.
- The kube-proxy ensures that traffic is routed to the correct containers, and the controller manager ensures that the desired state of the cluster is maintained.
