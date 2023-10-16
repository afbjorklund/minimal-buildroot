DOCKER = docker

IMAGE = buildroot/root

# docker import rootfs.tar rootfs
# docker run -it rootfs /bin/sh

.PHONY: image
image: Dockerfile rootfs.tar
	$(DOCKER) build -t $(IMAGE) .

.PHONY: run
run:
	$(DOCKER) run -it $(IMAGE)

root.tar:
	$(DOCKER) save -o $@ $(IMAGE)
