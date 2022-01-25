DOCKER = docker

IMAGE = buildroot/base

.PHONY: image
image: Dockerfile
	$(DOCKER) build -t $(IMAGE) .
