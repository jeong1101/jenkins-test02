podTemplate(label: 'docker-build',
  containers: [
    containerTemplate(
      name: 'git',
      image: 'alpine/git',
      command: 'cat',
      ttyEnabled: true
    ),
    containerTemplate(
      name: 'docker',
      image: 'docker',
      command: 'cat',
      ttyEnabled: true
    ),
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  ]
) {
    node('docker-build') {
        def dockerHubCred = jeonglinux_dockerhub
        def appImage

        stage('Checkout git'){
            container('git'){
                git 'https://github.com/jeong1101/jenkins-test02.git'
            }
        }

        stage('Build'){
            container('docker'){
                script {
                    appImage = docker.build("jeonglinux/node-hello-world")
                }
            }
        }

        stage('Test'){
            container('docker'){
                script {
                    appImage.inside {
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
            }
        }

        stage('Push'){
            container('docker'){
                script {
                    docker.withRegistry('https://registry.hub.docker.com',jeonglinux_dockerhub){ // dockerHubCred
                        appImage.push("${env.BUILD_NUMBER}")
                        appImage.push("latest")
                    }
                }
            }
        }
    }

}