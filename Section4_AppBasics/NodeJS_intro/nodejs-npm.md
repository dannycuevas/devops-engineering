-We have now set up NodeJS and we are ready to rock

-So it is now time to learn a little bit about
    libraries
    dependencies
    package management in nodejs
Because this is one area that we might struggle with when deploying applications

-You can run into:
    -dependency errors
    -unable to find libraries
    -mismatching versions

-NodeJS supports a large number of packages or libraries, these could be for example, packages for:
    -working with files
    -hosting web servers
    -interacting with databases
    -implementing security
    etc

-All of these packages are available at a Public Repo called:
npmjs.com


# NPM
-NPM stands for Node Package Manager

-NPM allows developers to develop new reusable packages, or modules, and share them on the public repo mentioned

-And so other developers can then download and use these packages on their projects, meaning, npmjs.com is the website that hosts this public repo with all of these mentioned packages

### npm
-When you install NodeJS, a command line utility called "npm" is alo installed automatically

-This "npm" utility helps you interact with the NPM repository, and to check the version run

npm -v

-Use "npm search" command along with the name of the package you are searching, it will list all packages available with that name

npm search PACKAGE_NAME
npm search file

-Once you have identified what package you need to install, use the "npm install" command, with the name of the package

npm install PACKAGE_NAME
npm install file

-The regular "npm install" command without any options, assumes you want to install the package in the current working directory

-When you install a package, npm installs it under the directoy below, under your present working directory, and its "code" will be llocated under its "lib" sub-directory

node_module

-There will also be a file called "package.json" and that is the file that contains the metadata for that package, this is a useful file in case that you are troubleshooting issues with dependancy errors

-You can install packages for 2 purposes:
    -One, for the application you are building
    -Two, globally across the system

-When we "import" a package into our application, node first looks at the local node_modules directory under our root "my_application" directory, for that package

-It if finds it, it uses that, if not, it looks for the package under the global directory

-So, to see the "list of paths" that node looks at, look at the "module.paths" configuration of node, so, to run the following command

node -e "console.log(module.paths)"

-You can also install a package "Globally" to be available across a system, using the -g opiotn at the end

npm install PACKAGE_NAME -g
npm install file -g


# COMMON MODULES

-There are 2 types of modules:
    -builtin modules
    -external modules

-Builtin modules are installed automatically when NodeJS runtime is installed for the first time and is available for use, they are located in the location:

ls /usr/lib/node_modules/npm/node_modules/

-External modules examples are:
    -express, popular web framework
    -react, use to create frontend user interfaces
    -debug, use to debug applications


# APPLICATION DEPENDENCIES

-An application or package, has a set of dependencies and scripts associated with it, these are recorded in the package JSON file

-So when developers build an application, they create this file in the "root of the project"

-This file, will contain the name and version of the application, along with a list of dependencies

-The dependencies, are packages or modules that this application requires, and the packages also have their versions defined

-So, installing different or unsupported dependencies can cause applications to not work, so it is important that these version are defined properly

-Also remember, that your application may have a "package JSON file" with the list of dependencies, and each of these packages may have their own "package JSON file" with their own dependencies, so do not get confused between the two

