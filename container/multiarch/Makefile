DOCKER = docker

IMAGE = buildroot/root

# docker run -d -p 5000:5000 --restart=always --name registry registry:2

REGISTRY = localhost:5000

all: image.x86_64 image.aarch64 manifest

image.x86_64: Dockerfile.x86_64 x86_64-rootfs.tar.gz
	$(DOCKER) build -t $(IMAGE)-amd64 -f Dockerfile.x86_64 .

image.aarch64: Dockerfile.aarch64 aarch64-rootfs.tar.gz
	$(DOCKER) build -t $(IMAGE)-arm64 -f Dockerfile.aarch64 .

.PHONY: run
run:
	$(DOCKER) run -it $(REGISTRY)/$(IMAGE)

manifest:
	@$(DOCKER) rmi -f $(REGISTRY)/$(IMAGE)-amd64
	$(DOCKER) tag $(IMAGE)-amd64 $(REGISTRY)/$(IMAGE)-amd64
	$(DOCKER) push $(REGISTRY)/$(IMAGE)-amd64
	@$(DOCKER) rmi -f $(REGISTRY)/$(IMAGE)-arm64
	$(DOCKER) tag $(IMAGE)-arm64 $(REGISTRY)/$(IMAGE)-arm64
	$(DOCKER) push $(REGISTRY)/$(IMAGE)-arm64
	@$(DOCKER) rmi -f $(REGISTRY)/$(IMAGE)
	$(DOCKER) manifest create --insecure --amend $(REGISTRY)/$(IMAGE) $(REGISTRY)/$(IMAGE)-amd64 $(REGISTRY)/$(IMAGE)-arm64
	$(DOCKER) manifest annotate --os linux --arch amd64 $(REGISTRY)/$(IMAGE) $(REGISTRY)/$(IMAGE)-amd64
	$(DOCKER) manifest annotate --os linux --arch arm64 $(REGISTRY)/$(IMAGE) $(REGISTRY)/$(IMAGE)-arm64
	$(DOCKER) manifest push $(REGISTRY)/$(IMAGE)
	$(DOCKER) rmi $(REGISTRY)/$(IMAGE)-amd64
	$(DOCKER) rmi $(REGISTRY)/$(IMAGE)-arm64
	$(DOCKER) manifest inspect $(REGISTRY)/$(IMAGE)
