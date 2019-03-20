# enigma_jenkins_docker
Enigma | Jenkins | Docker | Image Jenkins avec Docker

Build image
```
docker build -t jenkins/docker .
```

Run image
```
docker run --name jenkins_docker_dev -p 8080:8080 -v //var/run/docker.sock:/var/run/docker.sock jenkins/docker
```

Pipeline
```
pipeline {
  environment {
    registry = "rastadev01/enigma_jenkins_docker"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent none
  stages {
    stage('Cloning Git') {
      agent any
      steps {
        git 'https://github.com/averdier/enigma_jenkins_python'
      }
    }
    stage('Testing') {
      agent { docker { image 'python:3.7' } }
      steps {
        sh 'python test.py'
      }
    }
    stage('Building image') {
      agent any
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      agent any
      steps{
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      agent any
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}
```