# CONTROLLERS

-Controllers are the brain behind kubernetes
They are the processes that monitor kubernetes objects, and respond with actions as needed



## Replication Controller

-What is a replica? and why do we need a replication controller?
What if for some reason our application crashes and the pod hosting it fails?
then users will no longer be able to access our application

-So, to prevent from users losing access to our application,
we would like to have more than ONE instance or pod, and running at the same time

-This one, if any of them fails, we still have another one running our application

-The "Replication Controller" helps us run MILTIPLE instances of a single pod,
thus providing us with HIGH availability

-And even if you have a SINGLE POD, the replication controller can help you to automatically bring up a new pod when the existing one fails

-Thus, the "Replication Controller" ensures that the specified number of pods are running at all times, no matter what happens to the pods, even if it is just one pod or a hundred pods

### Load Balancing and Scaling
-Another reason we need the replication controller,
is to create multiple pods to share the load/traffic across them

-The replication controller can span across multiple nodes in the cluster, to deliver more instances(pods) of our application

-And so, it also helps us balance the load/traffic across multiple paths on different nodes, as well as scale our application whenever the demand increases

### Replica Set
-They sound pretty similar, but they are not the same

-Replication Controller is the onder technology that is being replaced,
by "Replica Set"

-Replica Set is the new recommended way to set up REPLICATION



## CREATE A REPLICA SET

-To create a replicat set, you will neeed your yaml configuration file,
and it will also have the 4 top level properties as with the pod yaml file,
but with some minor changes

-And as usual, "spec" defines what will be running INSIDE the object you are creating
And this is where you will provide the "template" dictionary, with the pod definition

-"Replicas" which is the number of replicas, as a sibling of the "template"

-Replica Set will also require a "selector" section definition,
The "selector" sections helps the replica set "identify" what PODS will fall under it


apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: app1-replicaset
  labels:
      app: app1
      type: front-end


spec:
  template:

      metadata:
          name: app1-pod
          labels:
              app: app1
              environment: production
      spec:
          containers:
              - name: nginx-version2
                image: nginx
  replicas: 4
  selector:
      matchLabels:
          type: front-end


### Selector Section
-Replica Set definitions need a "selector" section, mainly because,
Replica Sets can also MANAGE other PODS that were not created as PART of the replica set definition

-For the "selector" section, a USER input is required for this property to work,
and it has to be written in the form of "matchLabels"

-The "matchLabels" property will simply match the "labels" specified within it to the labels ON the pods, including the ones already created before

-And then to create the replica set we also use the kubectl create command


## REPLICA SET MONITORING

-So, you can create a Replica Set to MONITOR existing PODS as well as the ones that will be created, so it will work as a MONITOR tool for your PODS

-The role fo the Replica Set is to MONITOR the PODS,
and if any of them were to fail, well, to deploy new PODs

-How does the replica set know WHAT to monitor?
This is why we LABEL our PODs, and even more so during the creation of the replica set

We provide the LABELS to act as a FILTER for the Replica Set,
this labeling is done so using the "matchLabels" filter inside the "selector"
of our "Replica Set Definition File"


## SCALE UP THE REPLICA SET

-One way to do this, is to up the number of replicas in your replica set definition file

When going this way, you will need to "update" your running object (the replica set) with a kubectl command

kubectl replace -f REPLICA-FILE.yaml

-Another way to do it, is to use the "kubectl scale" command with the "--replicas:" parameter to provide an updated number of replicas, and specify the same file as input, or the replica set name

kubectl scale --replicas=6 -f REPLICA-FILE.yaml

kubectl scale --replicas=6 replicaset myapp-repli

-However, keep in mind that using the scale command will not result in the number of replicas being udpated in the actual replica set definition file, that will remain the same, unless changed manually

### Scale Down
-If you happen to create more PODs, for example using PODs definition files,
using the same label as your ReplicaSet definition (so they can get "monitored" too),

Then the replica set will automatically scale down or delete the number of pods that exceed the maximum number of replicas

-This is because even though you are creating more pods in a different manner,
since you are using the same label as your replica set, as if telling it that the new pod belongs to the same replica set

The replica set still understands that there is a maximum numbers of replicas to be hold at all times,
no matter how many pods you create (given you are using the same replica set label)


