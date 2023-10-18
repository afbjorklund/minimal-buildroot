qemu-system-aarch64 \
        -M virt \
        -cpu cortex-a53 \
        -bios /usr/share/AAVMF/AAVMF_CODE.fd \
	-smp 1 \
	-m 512 \
	-drive file=output/images/boot-arm64.iso,if=virtio,media=cdrom,id=cd0 \
        -device virtio-scsi-pci,id=cd0 \
	-netdev user,id=eth0 \
	-device virtio-net-pci,netdev=eth0
