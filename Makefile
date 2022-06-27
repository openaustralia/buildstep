
all: build

build:
	docker build -t openaustralia/buildstep:latest -f Dockerfile .
	docker build -t openaustralia/buildstep:early_release -f Dockerfile.early_release .
