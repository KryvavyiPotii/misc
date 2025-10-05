readonly ROOT_UID=0
readonly VERSION_PATTERN='^[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+(_[[:digit:]]+|())$'


is_root() {
    readonly _uid="$1"

    [ "$_uid" = "$ROOT_UID" ]
}

is_valid_kernel_version() {
    readonly _kernel_version="$1"

    echo "$_kernel_version" | grep -E -q "$VERSION_PATTERN"
}
