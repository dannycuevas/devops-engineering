-JavaScript paved the way for different "client-side" frameworks like:
    -jquery
    -angularJS
    -reactJS
    -vueJS
    -etc

-And all of this, are "client-side" technologies.
That is, they are used to build web-pages that would eventually run on clients or users systems, like our laptops for example

-They did not actually have anything to do with the application server itself


# NodeJS Platform

-In the past, server-side code, or the backend code, was mostly only on Java or Python, so you had one of these on the server side and then you would have a JavaScript based framework that would run on the "client-side" in their Browsers

-NodeJS took JavaScript our of the web browsers and onto the server side, also, NodeJS is free and open source, no licensing fee or anything of the like, and it is cross platform compatible (win, linux, etc)

-NodeJS is a server-side JavaScript environment that can be used to develop applications such as web-servers using JavaScript, and NodeJS will never be a "client-side" framework

-An important feature that distinguishes NodeJS from others is, its ability to handle a large number of concurrent connections by implementing a non blocking IO model

### Install NodeJS
-We will use CentOS as an example for an installation

-First, add the repository for NodeJS and then use the YUM install command

curl -sL https://rpm.nodesource.com/setup_13.x | bash

yum install nodejs

-Another version of the command to download and install NodeJS

curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -;sudo yum install -y nodejs

-"node" is the command line utility

node -v

-To run an application written in nodejs, then tu run it use the following command followed by the filename

node FILENAME.js
node add.js
