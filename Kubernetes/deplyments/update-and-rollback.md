
-The deployment provide us with the capability to upgrade the underlying instances (the instances already running), seamlessly using:
    -rolling updates
    -undo changes
    -and pause and resume your environment as required



# ROLLOUT AND VERSIONING

-When you first create a Deployment, it also triggers a ROLLOUT
A new ROLLOUT creates a new DEPLOYMENT-REVISION

Lets call that: revision1

-And so, in the future, when the application is upgraded, meaning,
when the containers version is udpated to a new one,
a NEW ROLLOUT is triggered and a NEW deplyment revision is also created,

We will name it: revision2

-This will help us keep track of the changes made to our deployment application,
and enables us to ROLL BACK to a "previous version" if necessary

-To check the status of your Rollout
kubectl rollout status deployment DEPLOYMENT-NAME
kubectl rollout status deploy myapp-deployment

-To see the Revisions and history of the Rollout
kubectl rollout history deploy DEPLOYMENT-NAME

-To revert updates-upgrades of a Deployment to the previous version
kubectl rollout undo DEPLOYMENT-NAME



# 2 TYPES OF DEPLOYMENT STRATEGIES

### First Type / Recreate Strategy
-One way to upgrade your instances (pods hosting containers) to a newer version is to DESTROY all of the current instances and then create newer ones,

The new ones will be holding newer versions of the application instances

-The problem with this approach, is that during the period of destroying the instances (older versions) and before the newer ones are up,
the application is down and inaccessible to the users


### Second Strategy / Rolling Update
-This is where we do not destroy all of the instances at once

-Instead, we bring down an older version, and bring up a newer version,
but one by one

-This way the application never goes down and the upgrade is seamless

-This one is the default deployment strategy,
UNLESS it is specified otherwise during the deployment



# HOW TO UDPATE A DEPLOYMENT

-For whenever we do any type of "update" to our deployment, like udpating any key value in the definition YAML file,

Since we already have a "deployment definition file", it would be "easy" for us to modify these files once all changes to the YAML file are completed

-We run the apply command to APPLY all the changes made to a definition file

kubectl apply -f FILENAME.yaml
kubectl apply -f deployment.yaml

-After this:
A NEW ROLLOUT is triggered, and a new REVISION of the deployment is created


### How it works
-When you upgrade your application deployment, the Kubernetes Dployment object will CREATE a new secondary Replica Set in the background

And it will start deploying the newer pod instances there

-At the same time, taking down the old instance pods in the old replica set,
and thus executing the ROLLING UPDATE strategy

-This can be visible by looking at the replica sets manually, using:
kubectl get rs



# ROLLBACK

-If something is wrong with the new version of your application deployment,
you can always ROLLBACK the update

-Kubernetes Deployments allow you to rollback to a previous REVISION

-To undo a deployment update, use the "undo" command, using the name of the deployment

kubectl rollout undo DEPLOYMENT / NAME

-The deployment will then destroy the pods in the newer replica set,
and bring back the older ones up, also in the older replica set
and there, the application is BACK to its older version



# KUBECTL RUN

-This command being use to create a pod, in fact, CREATES a "deployment"
and not just the POD all alone

kubectl run nginx --image=nginx

-So, this is another way of creating a deployment by only specifying the image name, and not USING a definition file

The required Replica Set and Pods are automaticaly created in the background

-Using the "Definition File" is the recommended way,
as you can save the file, check it into the code repository,
and modify it later as much as you want


