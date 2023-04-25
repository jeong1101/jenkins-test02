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
               //withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                  withCredentials([string(credentialsId: 'jeonglinux', variable: 'dockerhubpwd')]){
                  sh 'echo $MY_PASSWORD | docker login --username jeonglinux --password-stdin'                
                
                 //sh 'docker login -u jeonglinux --password-stdin'
                  //sh 'docker login -u jeonglinux --password-stdin ${dockerhubpwd}'
                }
               sh 'docker push jeonglinux/my-app'
            }
        }
    }
    
  }
}
