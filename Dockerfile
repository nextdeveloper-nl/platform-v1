FROM ubuntu:latest
LABEL version="3.0"
LABEL description="NextDeveloper Platform Image. For more information please visit: https://github.com/nextdeveloper-nl/platform-v1"
LABEL maintainer="rd@plusclouds.com"
RUN \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl man wget && \
  apt install -y nginx
EXPOSE 80
