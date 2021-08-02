Bare PC sample config
=====================

1. Build

  First select the appropriate target you want.

  For EFI-based boot strategy on an ISO-9660 image:

  $ make iso_x86_64_defconfig

  Add any additional packages required and build:

  $ make

2. Write the pendrive

  The build process will create a cd image called efiboot.iso in
  output/images.

  Write the image to a cd:

  $ dd if=output/images/boot.iso of=/dev/sdc; sync

  Once it's done insert it into the target PC and boot.

  Remember that if said PC has another boot device you might need to
  select this alternative for it to boot.

  In the case of EFI boot you might need to disable Secure Boot from
  the setup as well.

3. Enjoy

Emulation in qemu (UEFI)
========================

Run the emulation with:

qemu-system-x86_64 \
	-M pc \
	-cpu max \
	-m 512 \
	-bios </path/to/OVMF_CODE.fd> \
	-drive file=output/images/boot.iso,if=virtio,media=cdrom,id=cd0 \
	-device virtio-scsi-pci,id=cd0 \
	-netdev user,id=eth0 \
	-device virtio-net-pci,netdev=eth0

Note that </path/to/OVMF.fd> needs to point to a valid x86_64 UEFI
firmware image for qemu. It may be provided by your distribution as a
edk2 or OVMF package, in path such as
/usr/share/edk2/ovmf/OVMF_CODE.fd .
