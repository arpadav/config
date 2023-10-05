#!/bin/bash

# constants
MAX_DEPTH=2
INIT_NAME=".init~"

# remove all directory init files
find . -maxdepth $MAX_DEPTH -type f -name "$INIT_NAME" -exec rm -f {} \;

# copy all hidden dirs 
cd copy
cp -r .[^.]* ~/
cd - > /dev/null 2>&1

# copy all remaining contents
# shopt -s extglob
cp -r copy/* ~/

# echo off, re-init directory init files
find . -maxdepth $MAX_DEPTH -type d | while read -r dir; do
    if [[ ! "$(ls -A "$dir")" ]]; then
        touch "$dir/$INIT_NAME"
    fi
done

# unset all
unset MAX_DEPTH
unset INIT_NAME
