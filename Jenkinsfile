pipeline {
  agent any
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
        sh 'mvn clean package -Dmaven.test.skip=true clean install'
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
