#!/bin/sh

TMP_FILE_PATH="$(mktemp -u).png"

scrot "${TMP_FILE_PATH}"

[ -f "${TMP_FILE_PATH}" ] || exit 1

SCREENSHOT_DIR_PATH="/home/kryva/documents/screenshots/"

mkdir -p "${SCREENSHOT_DIR_PATH}"

CURR_TIMEDATE='{current_date_and_time}.png'
INPUT_NAME=$(echo "${CURR_TIMEDATE}" | dmenu -p 'Enter filename without extension:')

case "${INPUT_NAME}" in
    "")
        rm -f "${TMP_FILE_PATH}"
        exit 1
        ;;
        "${CURR_TIMEDATE}")
        SCREENSHOT_PATH="${SCREENSHOT_DIR_PATH}$(date +"%m-%d-%Y-%H%M%S").png"
        ;;
        *)
        SCREENSHOT_PATH="${SCREENSHOT_DIR_PATH}${INPUT_NAME}.png"
                ;;
esac

/usr/bin/mv "${TMP_FILE_PATH}" "${SCREENSHOT_PATH}"
