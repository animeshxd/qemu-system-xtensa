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

Enable Ethernet in ESP-IDF:
```
CONFIG_ETH_USE_OPENETH=y
```
Add this to your project's sdkconfig or enable it in `menuconfig` under 
```
Component config  --->
  Ethernet  --->
    [*] Support OpenCores Ethernet MAC (for use with QEMU)                  
```
Reference: https://github.com/espressif/esp-toolchain-docs/tree/main/qemu

## ESP32 Ethernet Code

For QEMU ESP32 Ethernet development:

```c
// Create OpenETH MAC instance
esp_eth_mac_t *mac = esp_eth_mac_new_openeth(&mac_config);

// Create DP83848 PHY instance 
esp_eth_phy_t *phy = esp_eth_phy_new_dp83848(&phy_config);
```

**OpenETH MAC**: Software Ethernet controller for QEMU virtualization  
**DP83848 PHY**: Compatible PHY driver that works with OpenETH in emulated environments

References:
- [ESP-IDF Ethernet API](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/network/esp_eth.html#driver-configuration-and-installation)
- [ESP-IDF Ethernet OpenETH Example](https://github.com/espressif/esp-idf/blob/27d68f57e6bdd3842cd263585c2c352698a9eda2/examples/common_components/protocol_examples_common/eth_connect.c#L150-L151)
