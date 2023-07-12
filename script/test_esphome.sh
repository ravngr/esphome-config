#!/bin/bash

## Globals/imports
SCRIPT_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export SCRIPT_PATH
REPO_PATH=$(readlink -f "${SCRIPT_PATH}/..")
export REPO_PATH


## CLI
if [ -z "$1" ]; then
    echo "Missing path argument"
    exit 1
fi

if ! [[ "$1" =~ config/[^/]+.yaml ]]; then
    echo "Ignore $1: not a device YAML file"
    exit 0
fi

if [[ "$1" =~ config/secrets[^/]+.yaml ]]; then
    echo "Ignore $1: secret YAML file"
    exit 0
fi

if ! [[ -f "${REPO_PATH}/config/secrets.yaml" ]]; then
    ln -s "${REPO_PATH}/config/secrets.ci.yaml" "${REPO_PATH}/config/secrets.yaml"
fi

esphome config "$1"
