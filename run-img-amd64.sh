qemu-system-x86_64 \
	-M pc \
        -cpu max \
	-bios /usr/share/OVMF/OVMF_CODE.fd \
	-smp 1 \
	-m 512 \
	-drive file=output/images/disk-amd64.img,media=disk,format=raw \
	-net nic,model=virtio \
	-net user
