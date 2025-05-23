FROM archlinux/archlinux

RUN pacman -Sy --noconfirm --needed pixman libgcrypt sdl2 zlib libslirp libgpg-error glib2 pcre2 rsync

# COPY ./qemu/bin/qemu-system-xtensa /usr/bin/qemu-system-xtensa
# COPY ./qemu/include/fdt.h /usr/include/fdt.h
# COPY ./qemu/include/libfdt_env.h /usr/include/libfdt_env.h
# COPY ./qemu/include/libfdt.h /usr/include/libfdt.h

# COPY ./qemu/lib/x86_64-linux-gnu/pkgconfig/libfdt.pc /usr/lib/x86_64-linux-gnu/pkgconfig/libfdt.pc
# COPY ./qemu/lib/x86_64-linux-gnu/libfdt.a /usr/lib/x86_64-linux-gnu/libfdt.a

# COPY ./qemu/share/qemu/esp32-v3-rom-app.bin /usr/share/qemu/esp32-v3-rom-app.bin
# COPY ./qemu/share/qemu/esp32-v3-rom.bin /usr/share/qemu/esp32-v3-rom.bin
# COPY ./qemu/share/qemu/esp32c3-rom.bin /usr/share/qemu/esp32c3-rom.bin
# COPY ./qemu/share/qemu/esp32s3_rev0_rom.bin /usr/share/qemu/esp32s3_rev0_rom.bin
COPY ./qemu /tmp/qemu
RUN rsync -a /tmp/qemu /usr/

COPY ./networking.sh /root/networking.sh
RUN chmod +x /root/networking.sh
CMD ["bash", "/root/networking.sh"]