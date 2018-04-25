#!/usr/bin/env bash

# USAGE: ./build.sh ./crafting-combinator-redux ~/factorio/mods/

MOD_DIRECTORY=${1}
TARGET_DIRECTORY=${2}

MOD_NAME=$(grep -m 1 -e 'name' ./crafting-combinator-redux/info.json | sed -e 's/.*"name": *"\(.*\)",.*/\1/')
VERSION=$(grep -m 1 -e 'version' ${MOD_DIRECTORY}/info.json | sed -e 's/.*\([[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+\).*/\1/')
PACKED_MOD_NAME=${MOD_NAME}_${VERSION}

ln -s ${MOD_DIRECTORY} ${PACKED_MOD_NAME}
rm -f ${TARGET_DIRECTORY}/${PACKED_MOD_NAME}.zip
zip -Dr ${TARGET_DIRECTORY}/${PACKED_MOD_NAME}.zip ${PACKED_MOD_NAME}
rm ${PACKED_MOD_NAME}