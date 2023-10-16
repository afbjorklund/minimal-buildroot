BUILDROOT_BRANCH = 2023.02.x

BUILDROOT_OPTIONS = BR2_EXTERNAL=$(PWD)

BUILDROOT_VARIANT = iso

BUILDROOT_MACHINE = $(shell uname -m | sed -e 's/arm64/aarch64/')

BUILDROOT_TARGET = $(BUILDROOT_VARIANT)_$(BUILDROOT_MACHINE)_defconfig

DIFF ?= diff

all: build

buildroot:
	git clone --single-branch --branch=$(BUILDROOT_BRANCH) \
	          --no-tags --depth=1 https://github.com/buildroot/buildroot

buildroot/.config: buildroot
	$(MAKE) -C buildroot $(BUILDROOT_OPTIONS) $(BUILDROOT_TARGET)

.PHONY: diff
diff:
	$(DIFF) -s buildroot/configs/pc_x86_64_efi_defconfig configs/pc_x86_64_efi_defconfig
	$(DIFF) -s buildroot/configs/aarch64_efi_defconfig configs/aarch64_efi_defconfig
	$(DIFF) -s buildroot/configs/qemu_x86_64_defconfig configs/qemu_x86_64_defconfig
	$(DIFF) -s buildroot/configs/qemu_aarch64_virt_defconfig configs/qemu_aarch64_virt_defconfig

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
