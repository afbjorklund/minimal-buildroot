#!/bin/sh
if [ -e /dev/kvm -a "`arch`" = "x86_64" ]; then
  options="-enable-kvm"
else
  options=""
fi
qemu-system-x86_64 -M pc $options -nographic -smp 1 -kernel output/images/bzImage -initrd output/images/rootfs.cpio -append "console=tty1 console=ttyS0" -net nic,model=virtio -net user
