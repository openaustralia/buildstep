
all: build

build:
# "latest" is currently the default tag used on morph.io
	docker build -t openaustralia/buildstep:cedar-14 -t openaustralia/buildstep:latest -f Dockerfile.cedar-14 .
# TODO: Get rid of use of early_release on morph.io when we can
	docker build -t openaustralia/buildstep:heroku-18 -t openaustralia/buildstep:early_release -f Dockerfile.heroku-18 .
