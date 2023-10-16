if [ -e /dev/kvm -a "`arch`" = "x86_64" ]; then
  accel="kvm"
else
  accel="tcg"
fi
qemu-system-x86_64 \
	-M pc \
        -cpu max \
	-bios /usr/share/OVMF/OVMF_CODE.fd \
	-smp 1 \
	-m 512 \
	-accel $accel \
	-drive file=output/images/disk-amd64.img,if=virtio,media=disk,format=raw,id=hd0 \
	-net nic,model=virtio \
	-net user
