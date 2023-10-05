#!/bin/bash
find . -type f -name ".init~" -exec rm -f {} \;
SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_NAME="$(basename "$SCRIPT_PATH")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
shopt -s extglob
mv "$SCRIPT_DIR"/!($SCRIPT_NAME) ~/
rm -- "$SCRIPT_PATH"
unset SCRIPT_PATH
unset SCRIPT_NAME
unset SCRIPT_DIR
