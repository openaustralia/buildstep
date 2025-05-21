
all: build

heroku-24: Dockerfile.heroku-24
	docker build -t openaustralia/buildstep:heroku-24 -f Dockerfile.heroku-24 .

cedar-14: Dockerfile.cedar-14
	docker build -t openaustralia/buildstep:cedar-14 -f Dockerfile.cedar-14 .

heroku-18: Dockerfile.heroku-18
	docker build -t openaustralia/buildstep:heroku-18 -f Dockerfile.heroku-18 .

build-obsolete: heroku-18 cedar-14

build: heroku-24

	
