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
After successful run of Jenkins pipeline new version of application should be running in autoscaling group.
We can access the application using loadbalancer dns name

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