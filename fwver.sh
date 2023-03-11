#!/usr/bin/env bash
# show OnePlus OTA update zip file version

[[ -z  "$(command -v unzip)" ]] && { echo "unzip not installed"; exit; }

if [[ "${#}" != "1" ]]; then
	echo "usage: $(basename ${0}) <ota_update.zip>"
	exit
fi

if [[ -r "${1}" ]]; then
	unzip -p "${1}" "META-INF/com/android/metadata" | grep "ota_version" | cut -d= -f2	
else
	echo "can't read ${1}"
fi
