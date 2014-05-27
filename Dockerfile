FROM ubuntu:quantal
MAINTAINER progrium "progrium@gmail.com"

RUN mkdir /build
ADD ./stack/ /build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
RUN apt-get install -y time
# Give the scraper user the same uid as deploy on the docker server
RUN mkdir /app
# TODO Currently hardcoded values
RUN addgroup --gid 4243 scraper
RUN adduser --home /app --no-create-home --disabled-login --gecos "Scraper User" --uid 4243 --gid 4243 scraper
VOLUME /data
RUN ln -s /data/data.sqlite /app/data.sqlite
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean
