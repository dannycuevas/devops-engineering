### References

Kubernetes Concepts – https://kubernetes.io/docs/concepts/

Pod Overview- https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/

## INSTALLING MINIKUBE

### kubectl command
-First we install kubectl

https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

### minikube
-Then we install minikube

https://minikube.sigs.k8s.io/docs/start/

-Start your cluster
minikube start

-Check the status of the minikube cluster node-components
minikube status

-If you already have kubectl installed, you can now use it to access your shiny new cluster
kubectl get po -A

-For additional insight into your cluster state, minikube bundles the Kubernetes Dashboard, allowing you to get easily acclimated to your new environment
#minikube dashboard


# MANAGE MINKUBE

-Pause Kubernetes without impacting deployed applications:
minikube pause

-Unpause a paused instance:
minikube unpause

-Halt the cluster:
minikube stop

-Change the default memory limit (requires a restart):
minikube config set memory 9001

-Browse the catalog of easily installed Kubernetes services:
minikube addons list

-Create a second cluster running an older Kubernetes release:
minikube start -p aged --kubernetes-version=v1.16.1

-Delete all of the minikube clusters:
minikube delete --all
