BUILDROOT_BRANCH = 2021.02.x

BUILDROOT_OPTIONS = BR2_EXTERNAL=$(PWD)

BUILDROOT_MACHINE = $(shell uname -m)

BUILDROOT_TARGET = iso_$(BUILDROOT_MACHINE)_defconfig

all: build

buildroot:
	git clone --single-branch --branch=$(BUILDROOT_BRANCH) \
	          --no-tags --depth=1 https://github.com/buildroot/buildroot

buildroot/.config: buildroot
	$(MAKE) -C buildroot $(BUILDROOT_OPTIONS) $(BUILDROOT_TARGET)

.PHONY: build
build: buildroot/.config
	$(MAKE) -C buildroot $(BUILDROOT_OPTIONS) world

.PHONY: download
download: buildroot/.config
	$(MAKE) -C buildroot $(BUILDROOT_OPTIONS) source

.PHONY: clean
clean:
	rm -f buildroot/.config
	$(MAKE) -C buildroot $(BUILDROOT_OPTIONS) clean
