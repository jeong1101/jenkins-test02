pipeline {
  agent any

  tools{
    maven 'M3'
    docker 'docker'
  }

/**  environment {
    mvn 빌드 & jar를 위한 환경 셋팅
    JAVA_HOME = "tool jdk-11.0.19+7"
    MAVEN_HOME = "tool maven-3.6.3"
    
    도커를 위한 환경 셋팅
    registry = "hsjeong17859@gmail.com"
    registryCredential = "dockerhub_cred" //jenkins에 따로 설정을 해야함 (manage Credenitals)
    dockerImage = ''
  }
**/
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
    stage('build Docker Image and Push'){
      steps{
          script{
              sh 'docker build -t my-app: -f Dockerfile .'
          }
      }
    }   

    //PUSH Image
    stage('Push Image'){
        steps{
            script{
                docker.withRegistry('https://registry.hub.docker.com', dockerhub_cred){
                  def image = docker.build("my-image:${env.BUILD_NUMBER}")
                  image.push()
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
