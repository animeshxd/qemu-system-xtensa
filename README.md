# QEMU System Xtensa

Docker project for configuring QEMU with Xtensa architecture support for ESP32 development.

QEMU source: https://github.com/espressif/qemu/releases/download/esp-develop-9.2.2-20250228/qemu-xtensa-softmmu-esp_develop_9.2.2_20250228-x86_64-linux-gnu.tar.xz

## Quick Start

Build and run the container:

```bash
docker build -t qemu-system-xtensa .
docker run -it --cap-add=NET_ADMIN qemu-system-xtensa
```

## Basic Usage

With firmware and networking:
```bash
qemu-system-xtensa \
    -nographic -machine esp32 \
    -drive file=build/build/flash_image.bin,if=mtd,format=raw \
    -nic tap,model=open_eth,ifname=tap0,script=no,downscript=no
```

## Network Setup

Networking is mandatory for QEMU open_eth:
```bash
sudo dhcpd -cf ./dhcpd.conf -f docker0
```

Reference: https://github.com/espressif/esp-toolchain-docs/tree/main/qemu
