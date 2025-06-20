#!/bin/bash

export maindir="$(pwd)"
export outside="${maindir}/.."
source "${outside}/env"

KSU_git_ver=$(cd KernelSU && git rev-list --count HEAD)
KSU_ver=$(($KSU_git_ver + 10000 + 200))

patch -p1 < patches/4.19/0001-fs-exec-add-ksu-execveat-hook.patch
patch -p1 < patches/4.19/0002-fs-open-add-ksu-faccessat-hook.patch
patch -p1 < patches/4.19/0003-fs-read_write-add-ksu-vfs_read-hook.patch
patch -p1 < patches/4.19/0004-fs-stat-add-ksu-vfs_statx-hook.patch
patch -p1 < patches/4.19/0005-drivers-input-input-add-ksu-input_handle_event-hook.patch

sed -i "s/\(CONFIG_LOCALVERSION=\)\(.*\)/\1\"-${kernel_name}-KSU${KSU_ver}\"/" "${defconfig_file}"

echo "$(grep 'CONFIG_LOCALVERSION=' ${defconfig_file})"

echo "includes KernelSU ${KSU_ver}" >> banner_append

