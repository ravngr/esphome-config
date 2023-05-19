#!/bin/bash

## Globals/imports
SCRIPT_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export SCRIPT_PATH

REPO_PATH=$(readlink -f "${SCRIPT_PATH}/..")
export REPO_PATH

. "${REPO_PATH}/deps/bashplate/bashplate.sh"


## CLI
if [ -z "$1" ]; then
    print_critical "Missing path argument"
    exit 1
fi

if ! [[ "$1" =~ config/[^/]+.yaml ]]; then
    print_info "Ignore $1: not a device YAML file"
    exit 0
fi


## Test configuration
file=$(basename "$1")

if [[ -f "${REPO_PATH}/config/secrets.yaml" ]]; then
    docker run \
        --rm \
        --name "esphome_config" \
        -v "${REPO_PATH}/config:/config" \
        "ghcr.io/esphome/esphome:${ESPHOME_TAG:-stable}" \
        config "${file}"
else
    docker run \
        --rm \
        --name "esphome_config" \
        -v "${REPO_PATH}/config:/config" \
        -v "${REPO_PATH}/config/secrets.ci.yaml:/config/secrets.yaml" \
        "ghcr.io/esphome/esphome:${ESPHOME_TAG:-stable}" \
        config "${file}"
fi
