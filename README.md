# Devops Test

## Prerequisites  
Install Jenkins
Docker image with git, maven and java to act as slave container for running jenkins pipeline
AWS Account and access keys
Replace ssh key pairs

## Infrastucture terraform  
### Creates below resources  
#### VPC  
Public Subnet  
Private Subnet  
Security Groups  
Internet Gateway  
Route Tables  
Bastion Host  
NAT  

## Image Pipeline  
### Packer  
Packer with Ansible provisiioner to create new AMI for Java web app  

## CICD Pipeline  
Jenkins pipeline build stage will run on code commit and build and create AMI  
In the deploy stage Jenkins pipeline will trigger terraform-asg to create asg with instances created from AMI created in build stage.


## Using this repo  
Clone this repository  
cd into infrastucture terraform directory  
run 
``` terraform plan ```  
If plan is successsful then run  
``` terraform apply --auto-approve ```  
To destroy infastruture  
``` terraform destroy --auto-approve ```  
Copy Subnets and RDS endpoint which are created from infructure terraform to terraform-asg  
Launch Jenkins  
Create neccessary credentials to use AWS access keys in pipeline  
Create pipeline job using Jenkinsfile provided in this repo  
Configure Git webhooks to trigger pipeline when code commit happens  
When code is commited Jenkins job will run and create new AMI with latest code and create new auto scaling group with instances created from new AMI
