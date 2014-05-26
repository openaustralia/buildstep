FROM ubuntu:quantal
MAINTAINER progrium "progrium@gmail.com"

RUN mkdir /build
ADD ./stack/ /build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
RUN apt-get install -y time
VOLUME /data
WORKDIR /data
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean
