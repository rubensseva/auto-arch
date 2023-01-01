#!/usr/bin/env sh

# deps
# pacman -S qemu qemu-system-x86 qemu-img qemu-desktop

QCOW_DISK_FILE_NAME=arch-test.qcow

if ! test -f "$QCOW_DISK_FILE_NAME"; then
    qemu-img create -f qcow2 $QCOW_DISK_FILE_NAME 20G
fi

qemu-system-x86_64 \
  -hda $QCOW_DISK_FILE_NAME \
  -m 2048 -enable-kvm -smp 4 \
  -cdrom archlinux-2022.12.01-x86_64.iso
