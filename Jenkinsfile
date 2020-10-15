pipeline {
  agent {
       docker {
          image 'arulkumar1967/build-arul-container:latest'
          args '-u root:sudo -v $HOME/workspace/test:/test'
        }
    }
  environment {
        EMAIL_RECIPIENTS = 'arulkr1967@gmail.com'
  }
  stages {

    stage('Test') {
      steps {
          sh 'mvn test'
		}
    }

    stage('Build') {
      steps {
          sh 'mvn package'
          sh 'rm -f packer/*.jar'
          sh 'cp -r target/*.jar packer'
        
	}

    }
    stage('Create Packer AMI') {
        steps {
          withCredentials([
            usernamePassword(credentialsId: 'arulawskey', passwordVariable: 'AWS_SECRET', usernameVariable: 'AWS_KEY')
          ]) {
            sh 'packer build -var aws_access_key=${AWS_KEY} -var aws_secret_key=${AWS_SECRET} packer/packer.json'
          }
       }
    }
    stage('AWS Deployment') {
      steps {         
          withCredentials([
            usernamePassword(credentialsId: 'arulawskey', passwordVariable: 'AWS_SECRET', usernameVariable: 'AWS_KEY'),            
          ]) {
            sh '''
               cd terraform-asg
               terraform init -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
               terraform apply -auto-approve -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
            '''
        }
      }
    }
  }
  
  }
