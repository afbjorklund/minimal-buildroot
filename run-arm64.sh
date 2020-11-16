qemu-system-aarch64 \
        -M virt \
        -cpu cortex-a53 \
        -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd \
	-smp 1 \
        -m 512 \
        -drive file=output/images/disk-arm64.img,if=none,format=raw,id=hd0 \
        -device virtio-blk-device,drive=hd0 \
        -netdev user,id=eth0 \
        -device virtio-net-device,netdev=eth0
