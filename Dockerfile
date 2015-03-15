FROM progrium/cedarish
MAINTAINER Jeff Lindsay <progrium@gmail.com>

# Beginning of changes for morph.io
RUN apt-get install -y libblas-dev liblapack-dev gfortran swig protobuf-compiler libprotobuf-dev libsqlite3-dev time
RUN mkdir /app
VOLUME /data
RUN ln -s /data/data.sqlite /app/data.sqlite
# End of changes for morph.io

ADD ./stack/configs/etc-profile /etc/profile

ADD ./builder/ /build
RUN xargs -L 1 /build/install-buildpack /tmp/buildpacks < /build/config/buildpacks.txt
