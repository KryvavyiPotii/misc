#!/bin/sh


. /usr/local/bin/libutil.sh


readonly ERR_PRIV=4
readonly ERR_INVALID_INPUT=5

readonly USAGE="Usage: $(basename $0) KERNELVERSION"


if ! is_root; then
    echo "Should be executed as root"
    exit $ERR_PRIV
fi

readonly kernel_version="$1"

if ! is_valid_kernel_version "$kernel_version"; then
    echo "$USAGE"
    exit $ERR_INVALID_INPUT
fi

readonly old_umask=$(umask)
readonly tmp_umask=0377

umask "$tmp_umask"
tar -Pzcf "/kernel_bp/${kernel_version}.tar.gz" \
    /boot/*"$kernel_version"* \
    /usr/src/*"$kernel_version"* \
    /lib/modules/*"$kernel_version"*
umask "$old_umask"
