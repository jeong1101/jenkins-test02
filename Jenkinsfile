pipeline {
  agent any
  tools{
    maven 'M3'
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
            sh 'docker build -t jeonglinux/my-app .'
            }
        }
    }
    stage('Push image to Hub'){
        steps{
            script{
               withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
               sh 'docker login -u jeonglinux -p ${dockerhubpwd}'
                }
               sh 'docker push jeonglinux/my-app'
            }
        }
    }
    
  }
}
