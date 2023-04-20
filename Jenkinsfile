pipeline {
  agent any
  environment {
    JAVA_HOME = "tool jdk-11.0.19+7"
    MAVEN_HOME = "tool maven-3.6.3"
  }

  stages {

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

     if (skipTests != true) {
            stage('Test') {
                sh "'${MAVEN_HOME}/bin/mvn' -P ${activeProfile} -Dmaven.test.failure.ignore -B verify"
            }
            stage('Store Test Results') {
                junit '**/target/surefire-reports/TEST-*.xml'
            }
     }
     stage('Build') {
             sh "'${MAVEN_HOME}/bin/mvn' -P ${activeProfile} -Dmaven.test.skip=true clean install"
     }
    stage('Archive') {
        archive '**/target/*.jar'
    }
    stage('Deploy') {
        echo "Deploy is not yet implemented"
    }

  }
}
