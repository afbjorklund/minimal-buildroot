# Minimal Buildroot

Trying to build a minimal buildroot for booting using emulator and as a virtual machine.

Just using the default setup from buildroot, will add custom kernel and software later.

* `board/`

* `configs/`

| Target   | amd64 (x86_64)                    | arm64 (aarch64)               |
| -------- | --------------------------------- | ----------------------------- |
| QEMU     | qemu/x86_64                       | qemu/aarch64-virt             |
|          | qemu_x86_64_defconfig             | qemu_aarch64_virt_defconfig   |
| UEFI     | pc                                | aarch64-efi                   |
|          | pc_x86_64_efi_defconfig           | aarch64_efi_defconfig         |

Just copied these files from buildroot, since it was hard to see the forest for the trees.

Some quirks: the x86_64 targets builds ext2 (not ext4), and without support for "virtio".

The name of the kernel and format of the initrd might also vary a bit, between the arch.

* `kernel/`

| Linux    | amd64 (x86_64)                    | arm64 (aarch64)               |
| -------- | --------------------------------- | ----------------------------- |
| Kernel   | kernel/x86_64_defconfig           | kernel/aarch64_defconfig      |
|          | linux/arch/x86/configs/           | linux/arch/arm64/configs/     |

These default configs were copied from the Linux kernel, and seen with "make defconfig".

----

New targets (based on UEFI above), making an `.img` disk with boot/root ext4 partitions.

|          | amd64 (x86_64)                    | arm64 (aarch64)                   |
| -------- | --------------------------------- | --------------------------------- |
| Image    | img/x86_64                        | img/aarch64                       |
|          | img_x86_64_defconfig              | img_aarch64_defconfig             |
|          | img/x86_64/linux.config           | img/aarch64/linux.config          |

amd64
```
Disk disk-amd64.img: 136,5 MiB, 142656000 bytes, 278625 sectors

Device          Start    End Sectors  Size Type
disk-amd64.img1    64  32831   32768   16M EFI System
disk-amd64.img2 32832 278591  245760  120M Linux root (x86)
```

arm64
```
Disk disk-arm64.img: 232 MiB, 243270144 bytes, 475137 sectors

Device          Boot Start    End Sectors  Size Id Type
disk-arm64.img1          1  65536   65536   32M ef EFI (FAT-12/16/32)
disk-arm64.img2      65537 475136  409600  200M 83 Linux
```

New targets (based on UEFI above), making an `.iso` (ISO-9660) output instead of an `.img`.

|          | amd64 (x86_64)                    | arm64 (aarch64)                   |
| -------- | --------------------------------- | --------------------------------- |
| ISO      | iso/x86_64                        | iso/aarch64                       |
|          | iso_x86_64_defconfig              | iso_aarch64_defconfig             |
|          | iso/x86_64/linux-extras.config    | iso/aarch64/linux-extras.config   |

amd64
```
boot-amd64.iso
├── boot
│   ├── initrd.img
│   └── vmlinuz
├── boot.catalog
└── EFI
    └── BOOT
        ├── bootx64.efi
        ├── efiboot.img
        └── grub.cfg
```

arm64
```
boot-arm64.iso
├── boot
│   ├── initrd.img
│   └── vmlinuz
├── boot.catalog
└── EFI
    └── BOOT
        ├── bootaa64.efi
        ├── efiboot.img
        └── grub.cfg
```

----

* `buildroot/`

This is the buildroot upstream, it is not modified except for the "output" directory.

* `output/`

This is where the sources and build happens, and where the output ends up afterwards.

```bash
git clone --branch=2023.02.x https://github.com/buildroot/buildroot
cd buildroot
make BR2_EXTERNAL=.. <*_defconfig>
make
```

* `support/`

Support files for building, such as a container image with all required build tools.

* `container/`

Contains helper files for constructing the container image from the rootfs archive.

----

```text
93M  output/images/disk-amd64.img
63M  output/images/disk-arm64.img
```

* [qemu-img-amd64.sh](qemu-img-amd64.sh)
* [qemu-img-arm64.sh](qemu-img-arm64.sh)

Start the emulator directly with the kernel and the rootfs in the same terminal window.

* [run-img-amd64.sh](run-img-amd64.sh)
* [run-img-arm64.sh](run-img-arm64.sh)

Start the emulator with the complete system image with grub in a new graphical window.

```text
12M  output/images/boot-amd64.iso
29M  output/images/boot-arm64.iso
```

* [qemu-iso-amd64.sh](qemu-iso-amd64.sh)
* [qemu-iso-arm64.sh](qemu-iso-arm64.sh)

Start the emulator directly with the kernel and the initrd in the same terminal window.

* [run-iso-amd64.sh](run-iso-amd64.sh)
* [run-iso-arm64.sh](run-iso-arm64.sh)

Start the emulator from the UEFI CD boot image instead of disk, otherwise same as above.
