FROM ubuntu:16.04
MAINTAINER matsuda <yacchin0101@gmail.com>

# append repo
RUN echo "deb http://at.archive.ubuntu.com/ubuntu/ xenial main universe" >> /etc/apt/sources.list

# package update & install
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y git nodejs npm curl

# latest node
RUN npm cache clean
RUN npm install n -g
RUN n stable
RUN ln -sf /usr/local/bin/node /usr/bin/node

# Set timezone
RUN echo "Asia/Tokyo" > /etc/timezone

# Fetch sorce
WORKDIR /var/
RUN git clone -b for_docker_compose https://github.com/khirayama/docker-training.git

# api setup
WORKDIR /var/docker-training/api/
RUN npm install

# web setup
WORKDIR /var/docker-training/web/
RUN npm install
