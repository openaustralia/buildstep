
all: build

build:
	docker build -t openaustralia/buildstep:cedar-14 -f Dockerfile.cedar-14 .
	docker build -t openaustralia/buildstep:heroku-18 -f Dockerfile.heroku-18 .
