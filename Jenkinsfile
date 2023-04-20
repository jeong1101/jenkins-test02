pipeline {
  agent any
  tools {
    maven 'M3'
  }

  stages {

    stage('Checkout Application Git Branch') {
        steps {
            git credentialsId: '{Credential ID}',
                url: 'https://github.com/best-branch/my-app.git',
                branch: 'develop'
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
  }
}
