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


rm /boot/*"$kernel_version"* >/dev/null
rm -r /usr/src/*"$kernel_version"* >/dev/null
rm -r /lib/modules/*"$kernel_version"* >/dev/null
