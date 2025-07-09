# YAML IN KUBERNETES

-Kubernetes can use YAML files as "inputs" for the creation of objects like:
    -pods
    -replicas
    -deployments
    -services
    -etc

-All of them follow a similar structure in the YAML file,
A "kubernetes definition file" ALWAYS contains 4 top level fields:

apiVersion:
kind:
metadata:

spec:

All of them are the "top level" or "root" PROPERTIES

-They are also required fields, so you MUST always have them in your YAML configuration files


### apiVersion
-This is the version of the kubernetes API we are using to create the object
-Make sure to always use the right version depending on your objects

pods        === v1
service     === v1
replicaset  === apps/v1
deployment  === apps/v1


### kind
-Kind refers to the type of object we are trying to create

pods
service
replicaset
deployment


### metadata
-This is the data about the object, like:
    -name
    -labels
    -etc
-Also, metadata will contain dictionaries with the data about the object,
this means, IDENTATION needs to be applied here carefully

-The key value for "name" is a string
-Under the key value of "labels", you can have any kind of key or value pairs as you like


### spec
-This one means "specification"
-Depending on the object we are going to create, this is where we would provide additional information to kubernetes partaining to that object in our YAML file

This means, this will always be different for different objects

-"spec" is a dictionary, and can contain lists or arrays

-Order of values inside SPEC for easier readability:
        -selector > matchLabel
        -replicas
        -template > metadata / spec



# YAML FILE CREATION

-Create a new object from your YAML file once the file is ready,
using the -f for the filename
kubectl create -f pod-definition.yaml
