#!/bin/bash

# Author: Arpad Voros

# define username
MOUNT_UID="vorosaa1"
MOUNT_USERNAME="vorosaa1"
MOUNT_DIR_0="/home/vorosaa1/mnt"

# ask for password
read -s -p "Mount password: " MOUNT_PASSWORD
echo

# create an associative array of shares to mount
declare -A mounts=(
    ["$MOUNT_DIR_0/CrossDept"]="//isilonshares/CrossDept"
    ["$MOUNT_DIR_0/KM"]="//isilonshares/apldata/aos"
    ["$MOUNT_DIR_0/AOS_public"]="//aplfsfalcon.jhuapl.edu/aodpublic\$"
    ["$MOUNT_DIR_0/aplshare"]="//isilonshares/aplshare"
    ["$MOUNT_DIR_0/software"]="//aplfsfrontier.jhuapl.edu/software" 
)

# iterate over the array
for mount in "${!mounts[@]}"
do
    # create the directory if it doesn't exist
    if [ ! -d "$mount" ]; then
        mkdir -p "$mount"
    fi

    # check if already mounted, skip
    if mountpoint -q -- "$mount"; then
        echo "$mount: already mounted, skipping..."
        continue
    fi

    # if the directory is not empty, skip
    if [ "$(ls -A $mount)" ]; then
        echo "$mount: not empty, skipping..."
        continue
    fi

    echo "$mount <== ${mounts[$mount]}"

    # auto enter predefined password
    sudo -S mount -t cifs -o username=$MOUNT_USERNAME,password=$MOUNT_PASSWORD,uid=$MOUNT_UID,domain=jhuapl,vers=3.0 "${mounts[$mount]}" "$mount"
done

# remove username from memory
unset MOUNT_UID
unset MOUNT_USERNAME

# remove password from memory
unset MOUNT_PASSWORD
