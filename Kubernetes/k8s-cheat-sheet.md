# KUBECTL COMMANDS

-To see all of the created objects at once
kubectl get all

-Check the options for the kubectl set image, for example to change values in your Deployments
kubectl set image --help

-List both the Pods and the Services using a single command
kubectl get pods,svc

-Getting the URL from a service using Minikube
minikube service SERVICE-NAME --url
minikube service voting-service --url

-Edit a current running object, like a pod, to change its properties/settings in real time,
this allows NOT having to re-run the creation of an object

kubectl edit pod PODNAME
kubectl edit pod redis

-Update an object once you have modified its YAML configuration file
this allows not having to delete and re-create the object from a YAML configuration file

kubectl apply -f FILENAME.yaml
kubectl apply -f redis-definition.yaml



# YAML FILES

-Create a new object from your YAML file once the file is ready,
using the -f for the filename
kubectl create -f pod-definition.yaml



# POD COMMANDS

-Creating a new pod with a new container of an application, using the specific image name
Image will be downloaded from your configured repository

kubectl run PODNAME --image IMAGE
kubectl run nginx --image nginx
kubectl run nginx --image=nginx

-Listing pods available in our cluster
kubectl get pods

-Showing basic internal information of pods, like for example
listing on which nodes are all the pods, or showing the podsinternal IPs address

kubectl get pods -o wide

-Get more information regarding an specific pod, including showing what pod it belongs to,
the pods internal IP address
the pod status
the pod IP address
the Image name used for the container
the container inside this pod

kubectl describe pod PODNAME
kubectl describe pod nginx

Node:             minikube/192.168.49.2 ===> on what node this is running and the node IP address
Start Time:       Sat, 24 Feb 2024 01:47:32 -0600 ===> when the pod was started
IP:               10.244.0.8 ===> pod IP address

-Delete a single pod
kubectl get pods
kubectl delete pod POD-NAME



# REPLICA SETS COMMANDS

-Create a new ReplicaSet from a yaml file
kubectl create -f FILE.yaml
kubectl apply -f FILE.yaml

-To view the list of created ReplicationControllers, as well as
the desired number of replicas or how many of them are ready
kubectl get replicationcontroller

-To see the list of created ReplicaSets

kubectl get replicaset
kubectl get rs

-To delete a ReplicaSet and underlying Pods
kubectl get rs
kubectl delete replicaset REPLICA-NAME
kubectl delete rs REPLICA-NAME

-To replace with an updated version the ReplicaSet
kubectl replace -f REPLICA-FILE.yaml

-Scale a ReplicaSet that is already running without modifying the yaml file
kubectl scale rs REPLICA-NAME --replicas=NUMBER

-View more information about your ReplicaSet by name
kubectl describe replicaset REPLICA-NAME
kubectl describe replicaset myapp-replicaset 

-Edit your ReplicaSet, but only the version in memory and not the actual yaml file,
for example to edit the number of replicas, this will not end up changing your yaml file at all

kubectl edit replicaset REPLICA-NAME
kubectl edit replicaset myapp-replicaset

-While checking a ReplicaSet, we have 0 READY pods,
why do you think the PODs are not ready?

=Run the command:
"kubectl describe pods" and look at under the Events section.
or
kubectl describe pods PODS-NAME | grep Error



# DEPLOYMENT COMMANDS

-Create your new Deployment using a YAML configuration file
kubectl create -f deployment-file.yaml

-List all your current Deployments

kubectl get deployments
kubectl get deployments -o wide

-Get "detailed internal" information on a specific Deployment,
this would even include the deployment strategy and its update events at the bottom

kubectl describe deployment DEPLOYMENT
kubectl describe deployment frontend-deployment

-When the pods in the Deployment are not ready, why do you think the deployment is not ready?

=Run the command: "kubectl describe pods POD-NAME" and look under the Events section.
kubectl describe pods POD-NAME
kubectl describe pods PODS-NAME | grep Error

### Example Deployment File

apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-deployment
spec:
  replicas: 6
  selector:
    matchLabels:
      name: myapp
  template:
    metadata:
	  name: nginx-2
      labels:
        app: myapp
    spec:
      containers:
      - name: nginx
        image: nginx
		

-Applying all changes made to the deployment definition file once it is saved

kubectl apply -f FILENAME.yaml
kubectl apply -f deployment.yaml

-To check the status of your Rollout
kubectl rollout status deployment DEPLOYMENT-NAME
kubectl rollout status deploy myapp-deployment

-To see the Revisions and history of the Rollout
kubectl rollout history deploy DEPLOYMENT-NAME

-To revert updates-upgrades of a Deployment to the previous version,
to rollback a deployment update

kubectl rollout undo DEPLOYMENT-NAME

-Make changes (in memory) to a running Deployment, and also keep it as a "record" for the "revision" versions of the deployment
kubectl edit deployment DEPLOYMENT-NAME --record
kubectl edit deploy myapp-deployment --record

-Find out the container name, run the command and look for the value "Containers:",
there you will see the name as the value just below it

kubectl describe deploy DEPLOYMENT-NAME
kubectl describe deploy myapp-deployment

-Change the image used in a deployment in a simple way, without modifying the yaml file, in a single command
kubectl set image deploy DEPLOYMENT CONTAINER=NEW-IMAGE
kubectl set image deploy myapp-deployment simple-app=kodekloud/webapp-color:v2



# NAMESPACES COMMANDS

-Create a new namespace
kubectl create namespace NEW-NAME
kubectl create namespace dev-space

-To list pods in a different namespace, by namespace name
kubectl get pods --namespace=NAMESPACE
kubectl get pods --namespace=kube-system

-Deploy a YAML file a different namespace other than the default namespace, by specifying the namespace
kubectl create -f FILE.yaml --namespace=NAMESPACE
kubectl create -f new-pod.yaml --namespace=dev-space

-SWITCH to a different namespace from the default one to run commands as normal
kubectl config set-context $(kubectl config current-context) --namespace=NEW-SPACE

-To view pods in all namespaces
kubectl get pods --all-namespaces


