# Devops Test

# Proposed Architecture
## Infrastructure  
### VPC
Public Subnet  
Private Subnet  
Security Groups  
Internet Gateway  
Route Tables  
Bastion Host  
NAT  
### Application EC2  
Nginx, RailServers in Private Subnet  
### Load balancers  
Application Load balancers in Public Subnet  
### Scalability  
Launch Configuration  
Auto scaling Group  
### Database  
MySQL in RDS in Private Subnet


## Configuration Management
### Ansible Playbook
Applications to be deployed  
Nginx  
Ruby  
Rails App  
Jenkins  

## Image Pipeline  
### Packer  
Packer with Ansible provisiioner to create new AMI for Rails App  

## CICD Pipeline  
### Rails Application Development
Create Rails Application Repository
Web hooks to trigger Jenkins pipeline job when developers commit code  
### Deploying new version of Rails APP
Jenkins pipeline job will run and it will build and create artifacts
Jenkins Image pipelie will run as downstream pipeline for the above pipeline and will create AMI
AMI will be updated in Terraform Launch Configuration and subsequent terraform run will update Auto scaling group instances with new image


## Using this repo  
### Prerequisites  
#### Tools to be installed in Local machine  
Terraform  
#### Tools to be installed in Jenkins server
Ansible
Packer
### Create Infrastructure
#### Run Terraform from local machine
```
Clone this repository
cd into terraform directory
run Terraform plan
If plan is successsful then run terraform apply --auto-approve
To destroy infastruture
terraform destroy --auto-approve
```
These steps can be integrated into Jenkins pipeline in a separate job named infrastructure setup

#### Ansible and Packer 
Ansible and Packer will run in Jenkins job.
Jekinsfile should be created for each pipeline with neccessary stages to execute pipeline tasks.
To run Ansible use below commnd  
```
ansible-playbook playbook.yml --key-file "/home/arulkumar/Documents/AWS/AccessKey/oct2020.pem"

```
To run Packer use below command  
```
packer build builder/railspacker.json 

```




