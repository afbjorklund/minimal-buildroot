#!/bin/sh
if [ -e /dev/kvm -a "`arch`" = "x86_64" ]; then
  options="-enable-kvm"
else
  options=""
fi
qemu-system-x86_64 -M pc $options -nographic -smp 1 -kernel output/images/bzImage -drive file=output/images/rootfs.ext2,if=virtio,format=raw -append "rootwait root=/dev/vda console=tty1 console=ttyS0" -net nic,model=virtio -net user
