FROM jenkins/jenkins:lts-alpine
USER root

RUN apk add --no-cache openrc docker
RUN rc-update add docker boot
