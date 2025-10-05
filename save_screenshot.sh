#!/bin/sh


tmp_file_path="$1"

[ -f "${tmp_file_path}" ] || exit 1

screenshot_dir_path="/home/kryva/documents/screenshots/"

mkdir -p "${screenshot_dir_path}"

curr_timedate='{current_date_and_time}.png'
input_name=$(echo "${curr_timedate}" | dmenu -p 'Enter filename without extension:')

case "${input_name}" in
    "")
        rm -f "${tmp_file_path}"
        exit 1
        ;;
    "${curr_timedate}")
        screenshot_path="${screenshot_dir_path}$(date +"%m-%d-%Y-%H%M%S").png"
        ;;
    *)
        screenshot_path="${screenshot_dir_path}${input_name}.png"
        ;;
esac

/usr/bin/mv "${tmp_file_path}" "${screenshot_path}"
