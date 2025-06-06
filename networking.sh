#!/usr/bin/env bash

ip link add br0 type bridge
mkdir /dev/net
mknod /dev/net/tun c 10 200
chmod 666 /dev/net/tun
ip tuntap add dev tap0 mode tap
ip link set tap0 master br0
ip link set eth0 master br0
ip link set tap0 up
ip link set br0 up

# If arguments are passed, execute them; otherwise sleep infinity
if [ $# -eq 0 ]; then
    sleep infinity
else
    exec "$@"
fi