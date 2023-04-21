pipeline {
  agent any
  
  tools{
    maven 'M3'
  }
  environment {
    // 도커를 위한 환경 셋팅
    registry = "hsjeong17859@gmail.com"
    registryCredential = "dockerhub_cred" //jenkins에 따로 설정을 해야함 (manage Credenitals)
    dockerImage = ''
  }
  
  stages {

    //git 체크
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    // mvn 빌드
    stage('Build') {
      steps {
        sh 'mvn clean package install'
      }
    }

    //mvn test
    stage('Test') {
      steps {
        sh 'mvn test'
      }
    }

    // docker img 빌드
    stage('build Docker Image'){
      steps{
          script{
              sh 'docker build -t my-app:${env.BUILD_NUMBER} -f Dockerfile .'
          }
      }
    }   

    //PUSH Image
    stage('Push Image'){
        steps{
            script{
                docker.withRegistry('https://registry.hub.docker.com', registryCredential){
                    dockerImage.push()
                }
            }
        }
    }

    
    stage('Deploy') {
      steps {
        sh 'mvn deploy'
      }
    }
  }
}
