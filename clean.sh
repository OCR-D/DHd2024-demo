#!/usr/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

WS_PATH="${SCRIPT_DIR}/Prinzenraub-DHd2024/data"
for name in ${WS_PATH}/OCR-D-*; do [ "$name" != ${WS_PATH}/OCR-D-IMG ] && rm -Rf -- "$name"; done
rm -f ${WS_PATH}/ocrd.log ocrd.log
git restore ${SCRIPT_DIR}/Prinzenraub-DHd2024/data/mets.xml
