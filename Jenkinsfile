pipeline {
  agent any
  tools{
    maven 'M3'
  }
  environment {
	registry = "jeonglinux"
	registryCredential = 'jenkins_dockerhub'
	dockerImage = ''
    }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Build docker image'){
    steps{
        script{
			dockerImage = docker.build registry + "/my-app:${env.BUILD_NUMBER}"
            }
        }
    }
    stage('Push image to Hub'){
        steps{
            script{
		withCredentials('', registryCredential) {
			dockerImage.push()
			}

	     }
        }
    }
    
  }
}
