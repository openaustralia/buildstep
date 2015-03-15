FROM progrium/cedarish
MAINTAINER Jeff Lindsay <progrium@gmail.com>

# Beginning of changes for morph.io
RUN apt-get install -y libblas-dev liblapack-dev gfortran swig protobuf-compiler libprotobuf-dev
RUN apt-get install -y time
# Give the scraper user the same uid as deploy on the docker server
RUN mkdir /app
# TODO Currently hardcoded values
RUN addgroup --gid 4243 scraper
RUN adduser --home /app --no-create-home --disabled-login --gecos "Scraper User" --uid 4243 --gid 4243 scraper
VOLUME /data
RUN ln -s /data/data.sqlite /app/data.sqlite
# End of changes for morph.io

ADD ./stack/configs/etc-profile /etc/profile

ADD ./builder/ /build
RUN xargs -L 1 /build/install-buildpack /tmp/buildpacks < /build/config/buildpacks.txt
