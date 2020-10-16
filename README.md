# Devops Test

## Architecture
AWS VPC with public, private subnets, route tables and internet gateway  
Load Balancer  
Autoscaling group where web application instances are running  
MySQL database running in RDS  
Java web application  
Jenkins for running pipeline  
Anisble / Packer for creating AMI  
Terrraform for creating AWS resources  

## Prerequisites  
Install Jenkins
Docker image with git, maven and java to act as slave container for running jenkins pipeline
AWS Account and access keys
Replace ssh key pairs   
Create s3 bucket with name smartpension-tfstate in eu-west-1 region   
Create DynamoDB table with name sp-locks with primary key field LockID   

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
Copy Subnets and vpc id which are created from infructure terraform to terraform-asg   
Copy RDS endpoint to src/main/resources/application.properties

Launch Jenkins  
Create neccessary credentials to use AWS access keys in pipeline  
Create pipeline job using Jenkinsfile provided in this repo  
Configure Git webhooks to trigger pipeline when code commit happens  
When code is commited Jenkins job will run and create new AMI with latest code and create new auto scaling group with instances created from new AMI
After successful run of Jenkins pipeline new version of application should be running in autoscaling group.
We can access the application using loadbalancer dns name

## Steps to run without Jenkins  
Install Packer, Terraform, Ansible, JDK, maven in local system  
Configure AWS credentials (access keys) in local system  
Clone the repo to local system  
### One time activity
cd to infrastructure/terraform directory  
run terraform commands  
 ```terraform  init```
 ```terraform  plan```
 ```terraform  apply --auto-approve```   
Copy the RDS enpoint to src/main/resources/application.properties file  
Copy subnets ids and vpc id to terraform.tfvars in terraform-asg folder  
### Repeatable for each commit    
run from root folder of repository   
```
mvn package  
rm -f packer/*.jar  
cp -r target/*.jar packer  
```  
cd to packer  
run ```packer build packer.json```  
After successful run of packer command AMI will be created in the configured aws region   
cd to terraform-asg   
run terraform commands   
 ```terraform  init```   
 ```terraform  plan```  
 ```terraform  apply --auto-approve```   
 This creats new auto scaling group with instances created from updated AMI   
 
## Testing application  
### Create table in RDS mysql instance with mysql client with below ddl command  
```
CREATE TABLE users ( id smallint unsigned not null auto_increment, user_name varchar(20), date_of_birth varchar(20), constraint pk_example primary key (id) );
```
### Sample Test Scripts
```
Command:
curl -X PUT \
  http://<Loadbalancerdns>/hello/Arul \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
    "dateOfBirth": "2007-06-12"
}'
Expected result:
No Response message. Row should be created in users table for Arul

Command:
curl -X GET \
  http://<Loadbalancerdns>/hello/Arul \
  -H 'Cache-Control: no-cache'
 Expected Result:
 Hello Arul Your birthday is in N Day(s)
```