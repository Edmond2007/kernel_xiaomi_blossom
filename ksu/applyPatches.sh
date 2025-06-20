#!/bin/bash

export maindir="$(pwd)"
export outside="${maindir}/.."
source "${outside}/env"

KSU_git_ver=$(cd KernelSU && git rev-list --count HEAD)
KSU_ver=$(($KSU_git_ver + 10000 + 200))

patchesdir="/home/runner/work/kernel_xiaomi_blossom/ksu/patches/4.19"
for patch_file in "$patchesdir"/*.patch ; do
  patch -p1 < "$patch_file"
done

sed -i "s/\(CONFIG_LOCALVERSION=\)\(.*\)/\1\"-${kernel_name}-KSU${KSU_ver}\"/" "${defconfig_file}"

echo "$(grep 'CONFIG_LOCALVERSION=' ${defconfig_file})"

echo "includes KernelSU ${KSU_ver}" >> banner_append

