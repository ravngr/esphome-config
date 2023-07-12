#!/usr/bin/env bash

WORKSPACE="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."

# Patch bash history
printf "export PROMPT_COMMAND='history -a'\nexport HISTFILE='/history/.bash_history'\n" >> "/home/${USER}/.bashrc"

touch /history/.bash_history
chown "${USER}:${USER}" /history/.bash_history

# Install requirements
pip install --upgrade pip
pip install -r "${WORKSPACE}/requirements.txt"
