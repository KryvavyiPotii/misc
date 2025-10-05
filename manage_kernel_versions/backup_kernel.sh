#!/bin/sh


. /usr/local/bin/libutil.sh


readonly USAGE="Usage $(basename $0) KERNELVERSION"

readonly kernel_version="$1"
readonly uid="$(id -u)"


if ! is_root "$uid"; then
    echo "Should be executed as root"
    exit 1
fi

if ! is_valid_kernel_version "$kernel_version"; then 
    echo "$USAGE"
    exit 1
fi


readonly old_umask=$(umask)
readonly tmp_umask=0377

umask "$tmp_umask"
tar -zcf "/kernel_bp/${kernel_version}.tar.gz" -P /boot/*"$kernel_version"*
umask "$old_umask"
