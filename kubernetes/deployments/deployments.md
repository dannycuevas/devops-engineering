# CONTROLLERS

-Controllers are the brain behind kubernetes
They are the processes that monitor kubernetes objects, and respond with actions as needed



# DEPLOYMENTS

-Lets talk about how you might want to deploy your application in a production environment, for example, a web server that needs to be deployed in a production environment

-So, you will need not one, but many instances of the web server (pods running containers running the application) running

-Secondly, whenever newer versions of application builds become available on the registry, you would like to upgrade your current instances seemlessly as well

However, when you upgrade your instances, you do not want to upgrade all of them at once

As this may impact all your logged in users that are accessing the applications, so you might want to upgrade the instances one after the other, like taking turns for example

And this kind of upgrade is known as "ROLLING UPGRADES"

-And so, suppose one of the upgrades you perform in one of the instances resulted in an unexpected error, and you are asked to undo that "recent change"

From here, you would like to be able to roll back the latest change that was recently carried out (that one upgrade)

-And finally, lets say for example, that you would like to make multiple exchanges to your environment, suchs as upgrading the underlying web server versions, 

As well as scaling your environment and also modifying the resource allocations, etc, you do not want to apply each language immediately after the command is run

-Instead you would like to apply a pause to your environment, make the changes and then resume, so that all the changes are rolled out together

-All of these capabilities are available with Kubernetes Deployments


### Deployment
-It is a kubernetes object that comes higher in the hierarchy, example:
    -pod
        -replica set
            -deployment

-The deployment provide us with the capability to upgrade the underlying instances (the instances already running), seamlessly using:
    -rolling updates
    -undo changes
    -and pause and resume your environment as required


# DEPLOYMENT CREATION

-As with the pod and replica set, we first create a deployment YAML file
The contents of the file are almost exactly the same as the configuration file of a replica set

-The key value changing here is the "kind", which is now going to be "deployment"

-Once created using the YAML file, the deployment automatically creates a "Replica Set", so you can also visualize the deployment using:
kubectl get replicaset DEPPLOYMENT

This new "Replica Set" will NOT create any extra pods, it will be the as PART OF the deployment,
and it will work only as a MONITORING tool of the deployment


### POD NAMING (yaml file)
-You can still have the key value for the PODs naming in the POD template,
inside the SPEC key, but since this is a Deployment, all the pods in the deployment will be NAMED after the deployment NAME

Hence, it really makes no difference, it would be just meaningless extra code,
example:

    template:
      metadata:
        name: app-pod <=== THIS one right here is the example
        labels:
          app: app-deployment
          tier: front-end
      spec:
        containers:
          - name: nginx-container
            image: nginx


