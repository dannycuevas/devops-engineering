-Now that we have our Application packaged into a Docker container, what is next?
How do we run it in production?

-What if your application relies on other containers/components such as databases or messaging services or other backend services?

-What if the number of users increase and you need to scale up your application?
and how do you scale down when the load decreases?

-To enable all of those functionalities, you need an "underlying platform",
with a set of resources and capabilities for these tasks

-The platform needs to "orchestrate" the connectivity between the containers,
and automatically scale up or down based on the load



# CONTAINER ORCHESTRATION

-This whole process of automatically deploying and managing containers is known as "Container Orchestration"

-Kubernetes is thus, a "container orchestration technology"

-There are various advantages of container orchestration

    Your application is now highly available, as hardware failures do not bring your application down, because you can have multiple instances of your application running on different nodes and containers

    The user traffic is load balanced across the various containers

    When the demand increases you can deploy more instances of the application seamlessly and within a matter of seconds, and we have the ability to do that at a service level

    When we run out of hardware resources we can scale the number of underlying nodes up or down, without having to take down the application

-And do all of these things easily with a set of declarative object configuration files, and this is "container orchestration" using Kubernetes

-Kubernetes is the the container orchestration technology used to orchestrate the deployment and management of hundreds and thousands of containers in a "clustered" environment
