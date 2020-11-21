#!/bin/sh
if [ -e /dev/kvm -a "`arch`" = "aarch64" ]; then
  options="-enable-kvm -cpu host -machine gic-version=3"
else
  options="-cpu cortex-a53"
fi
qemu-system-aarch64 -M virt $options -nographic -smp 1 -kernel output/images/Image -append "rootwait root=/dev/vda console=ttyAMA0" -netdev user,id=eth0 -device virtio-net-device,netdev=eth0 -drive file=output/images/rootfs.ext4,if=none,format=raw,id=hd0 -device virtio-blk-device,drive=hd0
