-Continuous Integration and Continuous Delivery/Deplyment is a way to
		-take code
		-package it up
		-and deploy it to a system
-That system could be serverless like an Azure Function, 
it could be a Virtual Machine,
it could be some container running somewhere with Docker
etc


# CI = Continuous Integration

-The gist of it is, you take the code and you package it up
-This is kind of like the "gift that you are wrapping"

-So the gift comes in pieces, like it comes from amazon, and once you get that gift, you take it out of the box and then you put that gift together
-Like you get multiple pieces, and you get a bunch of screws and nails, and you alse get the screwdriver and you make sure that all of the pieces are correctly put together and all that

-And once you do that and once everything is where is supposed to be, then the gift gets wrapped in the wrapping paper;
And this is your CI process

-Meaning, you are taking the code, you are packaging it up, and then you are giving it to the CD process to continuous

### Key Pieces of CI

1)
-The first is you package up that code
-So you have this github repository with a bunch of files and directories, and the CI process sort of clones that github repo and then it packages it up, it puts it in that little git box wraps it up like a gift

2)
-The next thing is, typically in your CI process is where you test your code, like for example;
	-unit testing
	-integration tests
-You want these tests to be run automatically, to make sure that that code is ready to go before you even try to deploy it, so you want to make sure it passes all your tests, you also want to make sure that it has all of the dependencies that are needed

(imagine trying to deploy an application, and once it is deploy you realize it is missing some libraries or missing the python package for example)

3)
-The last thing is, you would typically run any type of security checks against the code
-For example lets say, you are using some type of;
	-security lender
	-sonar cube
-This is the CI process where you would run those security checks against the code


# CD = Delivery and Deployment

-Continuous Delivery AND Continuous Deployment
-The CD process is where you deploy the code to some system

-That system could be;
		-serverless
		-virtual machines
		-containers
		-even bare metal (on-prem)

-Think about that gift that we wrapped in the CI section
-Once that gift is wrapped, it can be given to a person, so you take that wrapped gift, put it in your car, then drive to that person house and you deliver it to lets say their house front door, or something like that

-So basically, once the code is packaged,
and tested, and all that stuff in the CI process,
you then deliver it to whatever system you are running on


# CD versus CD

### Continous Delivery
-Continuous Delivery is, there is essentially some button somewhere to deploy the code for some manual intervention
-For example, lets say the code goes through the CI process and it is ready to be deployed, well then you would go into Jenkins and you would click the button to "deploy the code", so there is MANUAL intervention

### Continuous Deployment
-This one means that the code gets automatically deployed after the CI process
-Example, lets say that you are committing and pushing some code to github, so once it gets pushed to github, the CI process would automatically kick off and then once the code builds, the CD process would AUTOMATICALLY run and it would be deployed to your target system, without that magical button from the "delivery" process


### Key pieces of CD

1)
-Authentication; it ensure you are authenticated to the system or whatever you are deploying to
-Proper authentication at all times

2)
-Ensure that the code that is being deployed is working as expected once it is deployed
-For example, you can have another kind of test here, to run a test against the system to make sure that the application is running
-And if it is not running the way it is suppose to, then the CD process would fail
