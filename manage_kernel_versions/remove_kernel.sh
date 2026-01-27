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


rm -r \
    /boot/*"$kernel_version"* \
    /usr/src/*"$kernel_version"* \
    /lib/modules/*"$kernel_version"* >/dev/null#!/bin/sh
