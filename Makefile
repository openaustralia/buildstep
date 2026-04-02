
all: build

build:
	docker build -t openaustralia/buildstep:heroku-22 -f Dockerfile.heroku-22 .

	
