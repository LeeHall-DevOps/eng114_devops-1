# Jenkins

## Links

- [What is Jenkins](#what-is-jenkins)
- [What is CICD](#what-is-cicd)
- [Continuous Integration](#continuous-integration)
- [Continuous Delivery](#continuous-delivery)
- [Continuous Deployment](#continuous-deployment)
- [Difference between CD and CDE](#difference-between-continuous-delivery-and-deployment)
- [Pipeline](#pipeline)
- [Why Jenkins](#why-jenkins)
- [Setting up Jenkins](#setting-up-jenkins)
- [Setting up a webhook with Jenkins](#setting-up-a-webhook-with-jenkins)

## What is Jenkins

Jenkins is an open source automation server, Jenkins provides hundreds of plugins to support building, deploying and automating any project.

It offers a simple way to set up continuous integration (CI), continuous delivery (CD).

![Jenkins](./images/continuous-integration-with-jenkins.jpg)


![My own Jenkins diagram](./images/own-jenkins-diagram.png)

## What is CICD

Continuous Integration and Continuous Delivier is considered as the backbone of DevOps practices and automation, it plays a vital role in DevOps culture.

### Continuous Integration 

Developers merge/commit code to the main branch multiple times a day, full automated build and test processes which gives them feedback within a few minutes, by doing this, you are effectively avoiding the integration mayhem that happens when developers wait for the release day to merge all their changes into the release branch.

Is the practice of automating the integration of code changes from multiple contributors into a single software project. It's a primary DevOps best practice, allowing developers to frequently merge code changes into a central repository where builds and tests then run.

### Continuous Delivery

It's an extension of continuous integration to make sure that you can release new changes to your customers quicker in a much more sustainable method. So on top of your continuous integration, you also automated your release process and can deploy you application at any point of time by clicking a button. Deployment will have to be done manually but that can also be done automatically

### Continuous Deployment

This goes futher than Continuous Delivery by deploying the actually application online automatically, so each change that passes all the stages of your production pipeline is released to your customers, there is no human interaction so this lowers the chance for human error, and even one failed test will prevent the new change being deployed to production.

### Difference between Continuous Delivery and Deployment

The main difference is that on continuous delivery, you would have to deploy the application manually whereas continuous deployment is an extension of continuous delivery and deploys the application automatically as well as testing the application too.

### Pipeline

A CI/CD pipeline is all about automation: Intialising the code builds, automated testing, and automated deployment to staging or production enviroments. This saves the teams a lot of time as they don't have to create the tests and this process is *incredibly fast*.

## Why Jenkins

Jenkins has been adopted by the likes of Facebook, Netflix and Ebay because of it's incredible advantages. Jenkins is an open source automation server in which the central build and the continuous integration take place. It works on Windows, macOs, and Linux. It has a user-friendly interface, easy installation, extensible with a ton of plugin resource, and easy environment configuration.

## Setting up Jenkins

1. Create a key and add it to the repo as deploy key
2. Add the github url -> HTTPS to Jenkins
3. Go to the bottom of Office 365 connector where it says `Restrict where this project can be run` and type `sparta-ubuntu-node`
4. Source Code management
	- Click Git
	- Add repo url -> SSH
	- Create crendentials
	- Kind -> SSH Username with private key
	- ID -> Name of the key
	- Username -> Make it your own so mine is `eng114-florent`
	- Private Key -> Click **Enter Directly** -> **Add** -> Paste the entire private key - **Everything**
5. Build Environment
	- Select **Provide Node && npm bin/ folder to PATH**

## Setting up a webhook with Jenkins

1. Add the url so it should look like this `http://jenkins-ip:8080/github-webhook/
2. Go onto Jenkins
	- Select your project
	- Select configure
	- Scroll down to **Build Triggers**
	- Select **Github hook trigger for GITScm polling**
3. Now your webhook is fully configured
