# Kubectl Commands

-Complete Kubernetes reference guide
https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

- Get your AKS cluster credentials
```
az aks get-credentials -g <RG-NAME> -n <AKS-NAME>
```

- Install Kubernetes with kubeadm, we're going to specify the pod-network-cidr to use the subnet range of 10.10.0.1/16 and we're going to be implicit about the kubernetes version installed
```
kubeadm init --pod-network-cidr=10.10.0.0/16 --kubernetes-version=1.31.0
```

- Copy this local CNI configuration file to `/etc/cni/net.d` which is the standard location expected by Kubernetes. After this we'll run a `watch` command to see any changes to the node status as we configuring the network with that CNI file:
```
sleep 3 && cp /resources/cni/10-bridge.conf /etc/cni/net.d/ & watch kubectl get nodes -o wide
```

- Add or remove a taint, but with or without a minus `-` at the end
	- (`-`) minus at the end to remove
```
kubectl taint node <node-name> <taint-text>-

kubectl taint node <node-name> node-role.kubernetes.io/control-plane:NoSchedule-
```

- Describe, show all aspect, of a kubernetes object, for example a Deployment
```
kubectl describe deploy/nginx
```

- List all resources in all namespaces
```
kubectl get all -A
```

- Watch how is resource is being deploy and created so you do not have to be running multiple commands by using `-w` option (stands for "watch")
- You will see the "stages" changing on the fly but in real-time
```
kubectl get pods -w
```

- Create a proxy server that runs on the local machine by default on port 8001, and forwards all requests to the API server running in a kubernetes cluster
- This allows me to interact with the "API server" as if it was running on my local machine
- Example, you can `curl` the localhost (that is running the AKS cluster) to get information back in our terminal, like getting back the configuration of the kubelet of a specific Node to see its capacity and allocatable resources
```
kubectl proxy
```

```
curl -sSL "http://localhost:8001/api/v1/nodes/<NODE-NAME>/proxy/configz" | grep -i kubeReserved
```


# Kubeconfig

- See how to use the `kubeconfig` commands
```
kubectl config -h
```

- To make `kubelogin` work, if you're using this on a new machine or script, always do:
```
az login
az aks get-credentials -g <RG-NAME> -n <AKS-NAME>
kubelogin convert-kubeconfig -l azurecli
```

- Managing multiple clusters:
- You **do need to run the other two commands (`get-credentials` + `kubelogin`) for each AKS cluster** you want to manage
	- So for `az aks get credentials` you **must run this for each new AKS cluster** you want to access
	- And for `kubelogin convert-kubeconfig` you’ll typically run this **once after adding your clusters**, and it will update all AAD-enabled entries in your kubeconfig, but if you add a new cluster later, run it again to update the config
```
az login
az aks get-credentials -g <RG-NAME> -n <AKS-NAME>
kubelogin convert-kubeconfig -l azurecli
```

- Display your current `kubeconfig` context
```
kubectl config current-context
```

- List all your available AKS contexts
```
kubectl config get-contexts
```

- Switch to a different context using the context name, by using the `NAME` column names
```
kubectl config use-context CONTEXT-NAME
```


# AKS & Cluster Nodes

- List your Kubernetes nodes
```
kubectl get nodes
```

- Display all the information about a node
```
kubectl describe node <node-name>
```

- Example describing all of the cluster Nodes capacity by hostname, CPU, kubelet version, etc (all Nodes)
```
kubectl describe <NODE-NAME> | grep -e Hostname: -e cpu: -e Capacity: -e Allocatable: -e 'Kubelet Version' -e pods:
```

- Create a new cluster specifically using VMAS
```
az aks create -g <RG-NAME> -n <AKS-NAME> --vm-set-type AvailabilitySet --node-count 2
```

- Add another "Node Pool" (which will be VMSS by default) to an existing AKS cluster
	- in this example, we will pre-select "Azure Linux" as the OS for the Nodes
	- the new Node Pool will be named `marinerpool`
	- we will be using our existing RG `aks-rg` and cluster `aks`
```
az aks nodepool add --resource-group aks-rg --cluster-name aks --name marinerpool --os-sku AzureLinux --mode System --node-count 2
```

- Command to retrieve the OS image of your nodes:
```
kubectl get nodes -o custom-columns="Node Name:.metadata.name,OS Image:.status.nodeInfo.osImage
```

- Add a new Linux node pool no an existing AKS cluster using a local file `./linuxkubeletconfig.json` as the config file for a customized node pool for the Kubelet configuration
```
az aks nodepool add --name mynodepool1 --cluster-name <AKS-name> --resource-group <RG-NAME> --kubelet-config ./linuxkubeletconfig.json
```

- These are the commands to create new Node Pools with different OS disk types, so they are being selected each one specifically at creation time
	- we are using an already existing AKS cluster
	- we are just adding new Node Pools with different OS disk types with an specific "machine size" and specific disk size

```
az aks nodepool add --name <AKS-NAME> --cluster <AKS-CLUSTER> --resource-group <AKS-RG> -s Standard_B4ms --node-osdisk-type Ephemeral --node-osdisk-size 30 --node-count 2
```

```
az aks nodepool add --name <AKS-NAME> --cluster <AKS-CLUSTER> --resource-group <AKS-RG> -s Standard_B4ms --node-osdisk-type Managed --node-osdisk-size 30 --node-count 2
```

- Example "drain" command to gracefully evict the Pods from a Node Pool
	- "draining" also automatically "cordons" the Node Pool
```
kubectl drain <NODE-POOL-TARGET> --ignore-daemonsets --delete-emptydir-data
```

- Get the Azure Service Principal ID ans password from the AKS cluster, so you can actually search for it on the Azure portal
	- First remote into a cluster node, and then run the command with `root` user from inside the node
	- If the cluster is using Managed Identity, it will instead show `MSI` in the json output
```
cat /etc/kubernetes/azure.json
```

- Look at the Kubernetes certificates, first remote into a Node from the node pool, and then run the commands
	- and then check the expiry date of one of the certs using `openssl` commands
```
cd /etc/kubernetes/certs/
ls -l
openssl x509 -in CERT-NAME.crt -noout -enddate
```

- Check the AKS supported version for a specific region
```
az aks get-versions -l REGION-NAME -o table
az aks get-versions -l westeurope -o table
```

- Check the available upgrades for a specific AKS cluster
```
az aks get-upgrades -g <AKS-RG> -n <AKS-NAME> -o table
```


# Pods

- Remote into a Pod
```shell
kubecelt exec -it <POD-NAME> -- sh
```

- Run a command inside a Pod, without having to remote in
	- In this example, we want to see the storage space and capacity of a specific directory
```shell
kubectl exec -it <POD-NAME> -- df -h /mnt/azuredisk #> filepath
```

- List all your running Pods with all their details
```
kubectl get pods -o wide
```

- Look at the total of how many Pods are currently running
```
kubectl get pod -o wide | grep Running | wc -l
```

- Look at the total of how many Pods are currently running in all Namespaces in your cluster
```
kubectl get pod -o wide -A | grep Running | wc -l
```

- Look at the total of how many Pods are currently running in all Namespaces, but belonging to a specific Node
```
kubectl get pod -o wide | grep aks-node-name-000 | wc -l
```

- Star a pod with nginx, using the nginx image, then use `watch` to see how the pod is created and run
```
kubectl run nginx --image=nginx; watch kubectl get pods -o wide
```

- From that new running pod, let's capture the IP address to a variable called IP (and echo it to verify)
```
IP=$(kubectl get pods -o wide | grep nginx | awk {'print $6'}); echo $IP
```

- Run an alpine Linux pod, and be able to execute commands within the container
```
kubectl run alpine --image=alpine --restart=Never --rm -it -- /bin/sh
```

- Delete a pod using its name, in this case "alpine"
```
kubectl delete pod/alpine
```

- Create a pod running the Alpine Linux image with a custom environment variable, `MY_VARIABLE` set to "Hello, Kubernetes!"
	- And then verify that the environment variable is available within the pod
```
kubectl run alpine --image=alpine --restart=Never --rm -it --env="MY_VARIABLE=Hello, Kubernetes!" -- /bin/sh

# env
# echo $MY_VARIABLE
```

- Create a pod with the "OnFailure" restart policy
```
kubectl run nginx-onfailure --image=nginx --restart=OnFailure
```

- Create a pod with the "Never" restart policy
```
kubectl run nginx-never --image=nginx --restart=Never
```

- Look at the IP tables and rules for a specific Pod, run the command from inside the Node hosting the Pods
```
iptables -S | grep <POD-NAME>
```

- Check if a Pod can actually reach another Pod by using the target-Pod IP address
	- You need to be remoted into the source Pod first
```
kubectl get pod -o wide
kubectl exec -it <POD-NAME> -- bash
```
- From inside the source Pod, try to reach the target Pod to see if there is network connectivity
```
curl --connect-timeout 10 -v 66.66.66.6
```

- Display the current "Labels" of your running Pods
```
kubectl get pod --show-labels
```

- Apply only a "Label" to a specific Pod
	- first call the Pod name, and then the actual "label and value"
```
kubectl label pod <POD-NAME> NEW-LABEL=NEW-VALUE
```


# YAML

- Output the kubernetes YAML declaration for a Pod, without having to actually start or run a Pod, using the `-o yaml` to show us the output in yaml
	- Then send that output to an actual file in a path of our choosing, as this file can be used latter on for a deployment or something similar
```
kubectl run nginx --image=nginx --dry-run=client -o yaml
-
kubectl run nginx --image=nginx --dry-run=client -o yaml > /etc/kubernetes/resources/nginx_pod.yaml
```

- Create a new pod using a yaml file, using `-f`, from our local machine
```
kubectl apply -f /full/path/yaml-file.yaml

kubectl apply -f /etc/kubernetes/resources/nginx_pod.yaml
```

- Delete a pod using its own specific yaml file
```
kubectl delete --grace-predio=o -f /full/path/yaml-file.yaml

kubectl delete --grace-predio=o -f /etc/kubernetes/resources/nginx_pod.yaml
```


# Deployments

- List your running deployments
```
kubectl get deploy
```

- Create an nginx deployment. We'll use the image of nginx and we'll specify a port of 80. Specifying a port at this point will assist later on when using other Kubernetes functionality and is a recommendation when creating deployments
```
kubectl create deployment nginx --image=nginx --port 80
```

- List your current replica sets
```
kubectl get replicaset
kubectl get rs
```

- Now we can scale our previous deployment of nginx; "Deployments" can be easily scaled, execute the following command to increase the replica count to 2 and watch for changes with kubectl get pods
```
kubectl scale deploy DEPLOY-NAME --replicas 2
```

```
kubectl scale deployment/nginx --replicas=2; watch kubectl get pods -o wide
```

- Edit the current Deployment configuration (in its yaml format) in a text editor
```
kubectl edit deploy/nginx
```

- Look at the progress of a deployment rollout / modification in real time
```
kubectl describe deploy/<deploy-name>

kubectl describe deploy/nginx
```


# Services

- Let's create a `clusterIP` for our deployment, as we specified a port when creating the deployment, we can use the expose command, to expose this as a service
```
kubectl expose deployment/nginx --type=ClusterIP
```

- Expose a deployment with a Service-type Load Balancer, on port 80, and this will be using a public IP address
```
kubectl expose deploy <deploy-name> --port 80 --name <expose-service-name> --type LoadBalancer
```

- List all the available services
```
kubectl get service
```

- Capture the IP address of our service and echo it (like storing it as a variable)
```
SERVICE=$(kubectl get service | grep nginx | awk {'print $3'}); echo $SERVICE

curl $SERVICE
```

- Expose the pod or pods, of a deployment, in a specific port (it will automatically make it as "cluster IP")
```
kubectl expose deploy DEPLOY-NAME --name nginx-svc-server --port 80
```

- List all your endpoints, and their IPs
	- this will include multiple IPs for endpoints will multiple replicas
```
kubectl get endpoints
```


# Namespaces

- List all namespaces
```
kubectl get namespaces
```

- Check your current context and namespace
```
kubectl config current-context
```

- Command to Change the Namespace Context
```
kubectl config set-context --current --namespace=<namespace-name>
```

Example
```
kubectl config set-context --current --namespace=kube-system
```

- Switch back to the default namespace
```
kubectl config set-context --current --namespace=default
```

- Run a command in a specific namespace (if you don’t want to switch) by using the `-n` option
```
kubectl get pods -n <namespace-name>
```


# Debugging

- Look at the resource usages of your AKS nodes
```
kubectl top node
```

- Look at the resource usage of the pods
```
kubectl top pod
```

- Use the `kubectl debug` command to start a privileged container on your node and connect to it
```
kubectl debug node/aks-nodepool1-00000-00000 -it --image=mcr.microsoft.com/cbl-mariner/busybox:2.0
```

Elevate the session privileges
```
chroot /host
```

At the end, delete that one pod
```
kubectl delete pod node-debugger-aks-nodepool1-000-000000-bkmmx
```

Once inside a node, get the `kubelete` logs
```
journalctl -u kubelet -o cat
```

- Check the status of the `kubelete` component inside the node
```
systemctl status kubelet
```

- When you have deleted Azure resources by mistake, like deleting the cluster VMSS in Azure, you can "reconcile" your AKS cluster and make it rebuild the entire cluster, like rebuilding the VMSS machines and re-run the AKS cluster
```
az aks update -g AKS-CLUSTER-RG -n AKS-CLUSTER-NAME
```

- Create a cluster role that can view secrets within the entire cluster
```
kubectl create clusterrole <role-name> --verb=get,list,watch --resource=secrets
```

- List all your cluster roles
```
kubectl get clusterrole
```

- View the entire yaml file configuration for a specific cluster role
```
kubectl get clusterrole <role-name> -o yaml
```

- List all the config maps in your cluster
```
kubectl get cm -A
```

- Get the details in yaml format of a specific config map from a specific namespace
```
kubectl get cm -n <NAMESPACE> <CM-NAME> -o yaml
```

- Example copy command to move a file from inside a Node, to your computer for analysis, for example `tcpdump` command
```
kubectl cp [namespace]/[pod-name]:/path/of/file/file-name.cap /local-path/destination/file-name.cap
```

```
kubectl cp nsenter-94dshf:/root/capture.cap capture.cap
```


# Storage

- List your Storage Classes
```
kubectl get sc
```

```
kubectl get sc managed-csi
```

- List your Storage Classes in your cluster
	- This can be useful if you want to see if you have "allowed expansion" of Volumes
```
kubectl get sc
```

- List your Persistent Volumes and Persistent Volume Claims
	- This will display information such as size (in GB)  
```
kubectl get pv,pvc
```


# crictl CLI

- Check all the container images that exist inside a worker node
```
crictl images
```

- Check all the pods schedule inside of a worker node
```
crictl pods
```

- Check the containers running inside of a worker node
```
crictl ps
```

- Check the logs of a particular container running inside of a worker node
```
crictl logs CONTAINER-ID
```

