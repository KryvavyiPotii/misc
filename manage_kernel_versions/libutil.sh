readonly ROOT_UID=0
readonly KERN_VERSION_PATTERN='^[0-9]+\.[0-9]+\.[0-9]+(_[0-9]+|())$'
readonly HARD_DRIVE_PATTERN='^/dev/sd[a-z]$'


is_root() {
    readonly _uid="$(id -u)"

    [ "$_uid" = "$ROOT_UID" ]
}

is_valid_kernel_version() {
    readonly _kernel_version="$1"

    echo "$_kernel_version" | grep -E -q "$KERN_VERSION_PATTERN"
}

is_valid_hard_drive() {
    readonly _hard_drive="$1"

    echo "$_hard_drive" | grep -E -q "$HARD_DRIVE_PATTERN"
}
