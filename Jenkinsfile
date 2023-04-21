pipeline {
  agent any
  environment {
    // mvn 빌드 & jar를 위한 환경 셋팅
    JAVA_HOME = "tool jdk-11.0.19+7"
    MAVEN_HOME = "tool maven-3.6.3"
    
    // 도커를 위한 환경 셋팅
    registry = "hsjeong17859@gmail.com"
    registryCredential = "dockerhub_cred" //jenkins에 따로 설정을 해야함 (manage Credenitals)
    dockerImage = ''
  }

  stages {
    // git branch 체크
     stage('Checkout Application Git Branch') {
        steps {
            git credentialsId: 'c810ba10-1f7f-48a8-bf04-5a3fd7ca67a3',
                url: 'https://github.com/jeong1101/jenkins-test02.git',
                branch: 'master'
        }
        post {
                failure {
                  echo 'Repository clone failure !'
                }
                success {
                  echo 'Repository clone success !'
                }
        }
     }
    
    // 메이븐 빌드
     stage('Build') {
             sh "'${MAVEN_HOME}/bin/mvn' -P ${activeProfile} -Dmaven.test.skip=true clean install"
     }

     // .jar로 만들기
    /**stage('Archive') {
        archive '**/target/*.jar'
    } **/

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

    stage('Deploy') { //실패
        echo "Deploy is not yet implemented"
    }

  }
}
