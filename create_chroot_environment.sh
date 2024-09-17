#!/bin/bash

# USAGE: get_dependencies PATH_TO_BINARY
get_dependencies () {
  ldd $1 | grep -o -E '/lib.*\.[[:digit:]]+'
}

# USAGE: copy_files_to_chroot FILE_1 ... FILE_N PATH_TO_NEW_ROOT 
copy_files_to_chroot() {
  cp -v --parent "$@" 2>/dev/null
}

if [[ "$#" -lt 2 ]]
then
  echo "USAGE: $0 BINARY_1 ... BINARY_N PATH_TO_NEW_ROOT"
  echo "Description: creates the chroot environment with provided binaries."
  exit -1
fi

new_root_path="${@: -1}"

mkdir -p "$new_root_path"/{bin,lib,lib64,usr/bin}
echo "Created the new root directory $new_root_path."

files=""
for i in "$@"; do
  if [[ "$i" == "$new_root_path" ]]
  then
    break
  fi

  files+="$(which $i) $(get_dependencies "$(which $i)") "
done

copy_files_to_chroot $files $new_root_path
echo "Loaded all files."