#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="${SCRIPT_DIR}/.."

docker run \
    --name esphome-config \
    --rm \
    -v "${ROOT_DIR}/config:/config" \
    -p "6052:6052/tcp" \
    -e "TZ=${TZ}" \
    "ghcr.io/esphome/esphome:${ESPHOME_TAG:-stable}"
