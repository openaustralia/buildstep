
all: build

build:
	docker build -t openaustralia/buildstep:`git symbolic-ref --short HEAD` .
	docker build -t openaustralia/buildstep:`git rev-parse --short HEAD` .
