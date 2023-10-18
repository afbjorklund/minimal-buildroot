qemu-system-x86_64 \
	-M pc \
        -cpu max \
	-bios /usr/share/OVMF/OVMF_CODE.fd \
	-smp 1 \
	-m 512 \
	-drive file=output/images/boot-amd64.iso,if=virtio,media=cdrom,id=cd0 \
        -device virtio-scsi-pci,id=cd0 \
	-netdev user,id=eth0 \
	-device e1000,netdev=eth0
