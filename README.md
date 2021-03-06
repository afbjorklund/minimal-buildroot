# Minimal Buildroot

Trying to build a minimal buildroot for booting using emulator and as a virtual machine.

Just using the default setup from buildroot, will add custom kernel and software later.

* `board/`

* `configs/`

|          | amd64 (x86_64)                  | arm64 (aarch64)             |
| -------- | ------------------------------- | --------------------------- |
| QEMU     | qemu/x86_64                     | qemu/aarch64-virt           |
|          | qemu_x86_64_defconfig           | qemu_aarch64_virt_defconfig |
| UEFI     | pc                              | aarch64-efi                 |
|          | pc_x86_64_efi_defconfig         | aarch64_efi_defconfig       |
| Kernel   | x86_64_defconfig                | arm64_defconfig             |
|          | linux/arch/x86/configs/         | linux/arch/arm64/defconfig  |

Just copied these files from buildroot, since it was hard to see the forest for the trees.

----

* `buildroot/`

* `output/`

This is where the sources and build happens, and where the output ends up afterwards.

```bash
git clone --branch=2020.02.x https://github.com/buildroot/buildroot
cd buildroot
make BR2_EXTERNAL=.. <*_defconfig>
make
```

```text
93M  output/images/disk-amd64.img
63M  output/images/disk-arm64.img
```
----

* [qemu-amd64.sh](qemu-amd64.sh)
* [qemu-arm64.sh](qemu-arm64.sh)

Start the emulator directly with the kernel and the rootfs in the same terminal window.

* [run-amd64.sh](run-amd64.sh)
* [run-arm64.sh](run-arm64.sh)

Start the emulator with the complete system image with grub in a new graphical window.
