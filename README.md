docker build -t uboot-builder -f Dockerfile.builder .
cd u-boot
docker run -it --rm -v $(pwd):$(pwd) -w $(pwd) uboot-builder /bin/bash


# 1. Initialize standard RPi4/5 base
make rpi_arm64_defconfig

# 2. Force-enable the RP1 'Plumbing' (The jump to 49 devices)
scripts/config --enable CONFIG_PCI
scripts/config --enable CONFIG_PCIE_BRCMSTB
scripts/config --enable CONFIG_MISC_RP1
scripts/config --enable CONFIG_CLK_RP1
scripts/config --enable CONFIG_CLK_BCM2712
scripts/config --enable CONFIG_PINCTRL_RP1
scripts/config --enable CONFIG_BCMGENET

# 3. Bake the Boot Logic
scripts/config --set-str CONFIG_BOOTCOMMAND "pci enum; dhcp; setenv bootargs \${vendor-specific}; bootefi \${kernel_addr_r} \${fdtcontroladdr}"




docker run -it --rm -v $(pwd):$(pwd) -w $(pwd) uboot-builder  bash -c "make rpi_arm64_defconfig && make -j$(nproc)"; scp u-boot.bin root@node1:/mnt/nfs/talos-boot
