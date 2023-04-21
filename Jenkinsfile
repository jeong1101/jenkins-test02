pipeline {
  agent any

  tools{
    maven 'M3'
    docker 'docker'
  }

  environment {
    //도커를 위한 환경 셋팅
    repository = "jeonglinux/jenkins-example" //docker hub id와 repository 이름
    DOCKERHUB_CREDENTIALS = "dockerhub_jenkins" //jenkins에 따로 설정을 해야함 (manage Credenitals)
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

/**
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
**/
    //build img docker
    stage('Building our image') { 
          steps { 
              script { 
                  sh "cp /var/jenkins_home/workspace/jenkins-test02/target/my-app2-1.0-SNAPSHOT.jar /var/jenkins_home/workspace/pipeline/" // war 파일을 현재 위치로 복사 
                  dockerImage = docker.build repository + ":$BUILD_NUMBER" 
              }
          } 
    }

    stage('Login'){
          steps{
              sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin' // docker hub 로그인
          }
    }

    stage('Deploy our image') { 
        steps { 
            script {
              sh 'docker push $repository:$BUILD_NUMBER' //docker push
            } 
        }
    } 

    stage('Cleaning up') { 
      steps { 
            sh "docker rmi $repository:$BUILD_NUMBER" // docker image 제거
        }
    } 

  }
}
