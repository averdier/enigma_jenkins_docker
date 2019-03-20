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