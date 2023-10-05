#!/bin/bash
find . -type f -name ".init~" -exec rm -f {} \;
shopt -s extglob
cp -r copy/ ~/
