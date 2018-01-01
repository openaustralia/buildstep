FROM openaustralia/morph-docker-buildstep-base

RUN curl https://github.com/gliderlabs/herokuish/releases/download/v0.3.33/herokuish_0.3.33_linux_x86_64.tgz \
		--silent -L | tar -xzC /bin

# install herokuish supported buildpacks and entrypoints
RUN /bin/herokuish buildpack install

# Add perl buildpack for morph
RUN /bin/herokuish buildpack install https://github.com/miyagawa/heroku-buildpack-perl.git 2da7480a8339f01968ce3979655555a0ade20564
