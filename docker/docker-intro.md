-Containers are completely isolated environments, as in they can have their own
processes or services
their own network interfaces
their own mounts, just like VM,
except, they all share the same OS kernel


### Operative System Concepts
-If you look at OS like ubuntu, fedora, centos, etc, they all consist of 2 things:
		-the OS kernel
		-a set of software

-"OS Kernel" is reponsible for interacting with the underlying hardware, AND the "software" above the system is what makes these operating systems different (ubuntu, fedora, centos, etc)

-The set of software then, may consist of a different user interface, drivers, compilers, file managers, developer tools, etc

-So you have a common Linux kernel that is shared across ALL OSes, and some "custom software" that differentiate operating systems from each other

### Docker sharing the kernel
-We have said then, that docker containers share the underlying kernel, but what does that mean?

-So if you have a linux machine with docker installed on it, you can run containers that run linux machines, but not containers that run windows machines, for that you will need a windows machine with docker installed on it

-Windows can run linux containers? yes, but that is because when you install docker on windows, it sort of installs a linux virtual machine that will allow you to run linux containers, so your windows machine runs a linux virtual machine that can run linux containers

### Docker is not a Hypervisor
-This is because Docker is not meant to "virtualize" and run different operating systems and kernels on the same hardware

-The main purpose of docker is to package and containerized applications, and to ship them and to run them anywhere anytime as many times as you want


# Containers VS Virtual Machines

-In the case of Docker, we have:
		-the underlying hardware infrastructure
		-then the OS
		-then Docker installed on the OS
		-from here Docker then manages the containers, that run with libraries and dependencies alone
		
-In the case of virtual machines, we have:
		-the hypervisor, like ESX on the hardware
		-then the virtual machines on them
		-as each VM has its own OS inside it, along with the dependencies, and the apps

### Resource utilization
-So in the case of VMs, the overhead costs us higher utilization of underlying resources as there are multiple virtual operating systems and kernels running

-The VMs also consume higher disk space as each VM is heavy and is usually in gigabytes in size, whereas Docker containers are lightweight and are usually in megabytes in size

-This allows containers to boot up faster, usually in a matter of seconds, whereas VMs can take minutes to boot up as they need to boot up an entire operating system

-Also important to note, that docker has less isolation as more resources are shared between the containers, like the kernel, AND the VMs have complete isolation from each other since VMs do not rely on the underlying OS or kernel

### Containers with VMs
-Now when you have large environments with thousands of application containers running on thousands of docker hosts, you will often see containers provisioned on "virtual docker hosts", this way, we can utilise the advantages of both technologies

-So, we can use the benefits of virtualization to easily provision or decommission Docker host servers as required
-At the same time, make use of the benefits of Docker to easily provisioned applications and quickly scale them as required


# Container VS Image

### Images
-An Image is a package or a template (just like a VM template that you might have worked with in the virtualization world), used to create 1 or more containers from that "base" image

### Containers
-Containers are running instances (of those Images), that are isolated and have their own environments and set of processes


# Docker in DevOps

-Traditionally speaking, developers would develop applications, then they hand it over to ops team to deploy and manage the application in production environments

-They do that by providing a set of instructions, such as:
		-information about how the host must be set up
		-what prerequisites are to be installed on the host
		-and how the dependencies are to be configured

-Now, since the OPS team did not really developed the application on their own, they struggle with setting it up when they hit an issue, so they work with the developers to resolve it

-With Docker, the developers and operations team work hand in hand, to transform the guide into a Docker file with both of their requirements

-This Docker file is then used to create an image for their applications, and so this Image can now run on any host with Docker isntalled on it, and is guaranteed to run the same way everywhere

-So now the OPS team can now simply use the Image to deploy the application, as it continues to work the same way when deployed in production, and this is one example of how a tool like Docker contributes to the DevOps culture
