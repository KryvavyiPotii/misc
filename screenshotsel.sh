#!/bin/sh


save_screenshot_script="./save_screenshot.sh"


[ -f "${save_screenshot_script}" ] || exit 1


tmp_file_path="$(mktemp -u).png"


scrot "${tmp_file_path}" -s -l mode=edge


"${save_screenshot_script}" "${tmp_file_path}"
