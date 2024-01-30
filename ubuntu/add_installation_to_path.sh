#!/bin/bash

# get the current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# loop through sub directories
for d in $DIR/*/ ; do
    # if there are any binary files in this folder, add to path
    if [ -f "$d"*.bin ]; then
        export PATH=$PATH:$d
    fi
    # if there is a folder called 'bin', add it to path
    if [ -d "$d/bin" ]; then
        export PATH=$PATH:$d/bin
    fi
done
