
all: build

build:
	# "latest" is currently the default tag used on morph.io
	docker build -t openaustralia/buildstep:latest -f Dockerfile .
	docker build -t openaustralia/buildstep:cedar-14 -f Dockerfile .
	docker build -t openaustralia/buildstep:early_release -f Dockerfile.early_release .
	docker build -t openaustralia/buildstep:heroku-18 -f Dockerfile.early_release .
