# CI/CD workflow for Node.js application with Jenkins and Kubernetes
This repository provides information on how to set up a CI/CD workflow of a Node.js application hosted on Kubernetes.


## Table of Contents
* Prerequisites
* Application Set-up Workflow
* File Structure


## Prerequisites
* GitHub account.
* Docker Hub account.
* AWS account with (use Terraform to spin up servers):
  - Jenkins server (t2.micro)
  - SonarQube server (t2.medium)
  - Kubernetes Master server (t2.medium)
  - Kubernetes Worker One server (t2.micro)
  - Kubernetes Worker Two server (t2. micro)

![image](https://user-images.githubusercontent.com/73691007/128066213-79e4754e-aca6-44d6-868c-2e8250450111.png)

## Application Set-up Workflow
![image](https://user-images.githubusercontent.com/73691007/128065042-48bf0510-8b9d-47e7-b16c-42ea93eb4a7e.png)

## Step 1 — Setting up Jenkins server
* Create t2.micro instance in AWS and name for it. **Example:** jenkins-server
* Software to be installed on Jenkins machine:
  - Java
  - Git
  - Jenkins
  - Ansible
  - Terraform
* Once all the required software are installed Jenkins can be accessed via `http://<jenkins-server-IP>:8080`
* Login to Jenkins and install the below plugins:
  - Ansible plugin
  - NodeJS Plugin
  - SonarQube Scanner for Jenkins
  - Office 365 Connector

## Step 2 — SonarQube server set-up and integration with Jenkins
* Create t2.medium instance in AWS and name for it. **Example:** sonar-qube-server
* Install SonarqQube Server software in sonar-qube-server and start sonar.
* Login to Jenkins and Integrate SonarQube server with Jenkins. (Jenkins -> Manage Jenkins -> Configure System -> SonarQube servers)

 **NOTE:** SonarQube server can be access by `http://<sonar-qube-server-IP>:9000`

## Step 3 — Set-up Kubernetes cluster
* Create 3 instances in AWS (use Terraform to spin up servers):
  - 1 t2.medium instance and name it. **Example:** K8-Master-Server
  - 2 t2.micro instances and name it. **Example:** K8-Worker-One, K8-Worker-Two
* Set-up Kubernetes cluster using Kubeadm.

## Step 4 — Create sample Node.js application and push to GitHub
![image](https://user-images.githubusercontent.com/73691007/128066316-7a64b281-66a2-4835-a46f-94f306957d21.png)

## Step 5 — Create Pipeline job in Jenkins and Run it
![image](https://user-images.githubusercontent.com/73691007/128066355-9c7de163-edc6-411f-8e65-2a90531260c9.png)

## Step 6 — Access your Node.js application on `http://<Master/Worker-IP>:31200/`
![image](https://user-images.githubusercontent.com/73691007/128066531-e899f2f7-3df8-46d8-a700-0a5c32592776.png)
### Note: In real world scenario the application would have been accessed via domain name. Ex: www.sampleapp.com which can be achieved using NGINX and Router 53 AWS service. However these tools were not used as they charge a lot for Elastic Load Balancer (ELB) and Router 53 in AWS. 

## Step 7 — Access monitoring tools
### Prometheus `http://<MasterIP>:30000/`
![image](https://user-images.githubusercontent.com/73691007/128066849-6f79526f-926f-4fc3-8242-36c9ebb9b95c.png)

### Grafana `http://<MasterIP>:32000/`
![image](https://user-images.githubusercontent.com/73691007/128066906-650c6ca3-0c74-4f9f-9398-d0a650628bc3.png)

## File Structure
![image](https://user-images.githubusercontent.com/73691007/128066981-c2eab8cb-437f-4bba-8fea-f1657cab76e2.png)

### Explanations regarding structure:
* **Dockerfile:** contains instructions to build Docker image.
* **Jenkinsfile:** contains steps to run the Jenkins pipeline.
*	**MASTER-SERVER-FILES:** Files in this folder are actually present in the Master Node. These files are placed here convenience purpose **ONLY**
    - **nodejs-app-helm:** helm chart for our Node.js project. All the required manifests files are placed inside the helm chart.
  **Note:** To demonstrate with and without referring inputs for manifest files from “values.yml” file the below actions are performed:
        * For “hpa.yml”, “service.yml” referred inputs from “values.yml”
        * For “deployment.yml”, ”namespace.yml” inputs are not referred from “values.yml”
    - **prometheus-grafana:** We can deploy Prometheus and Grafana easily using Helm charts. However to demonstrate the deployment without using Helm charts I have written all manifests file individually.
* **package.json:** records important metadata about a project which is required before publishing to NPM, and also defines functional attributes of a project that npm uses to install dependencies, run scripts, and identify the entry point to our package.
* **playbooks:** contains ansible playbooks which assists in deploying our Node.js application and monitoring tool in Kubernetes cluster.
    - **hosts:** stores information about remote nodes, which we need to manage.
    - kubernetes-helm-deployment.yml: playbook to deploy node.js application to Kubernetes application.
    - kubernetes-monitoring-deployment.yml: playbook to deploy Prometheus and Grafana to Kubernetes application.
* **server.js:** handles our application startup, routing and other functions.
* **sonar-project.js:** contains SonarQube server details, properties, etc.
* **terraform-scripts:** Infrastructure As Code (IAC) tool.
    - To demonstrate writing of terraform scripts with and without the use of “modules” the below actions are performed:
      - Used “modules” for
        - S3
        - DynamoDB
        - Terraform backend













