#!/bin/bash
set -e

export maindir="$(pwd)"
export outside="${maindir}/.."
source "${outside}/env"

cd KernelSU
./build.sh kernel_patch "${outside}"

# Версия KSU для баннера
KSU_git_ver=$(git rev-list --count HEAD)
KSU_ver=$((KSU_git_ver + 10000 + 200))

cd "${maindir}"

# Обновляем CONFIG_LOCALVERSION
sed -i "s/CONFIG_LOCALVERSION=.*/\1\"-${kernel_name}-KSU${KSU_ver}\"/" "${defconfig_file}"
echo "$(grep 'CONFIG_LOCALVERSION=' ${defconfig_file})"

echo "includes KernelSU ${KSU_ver}" >> banner_append
