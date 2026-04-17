#!/bin/bash

# Configuration for the Shared Drive
UUID="01DCCD67019D3DC0"
MOUNT_POINT="/mnt/SharedDrive"
FSTAB_ENTRY="UUID=$UUID $MOUNT_POINT ntfs-3g rw,user,uid=1000,gid=1000,dmask=022,fmask=133,x-gvfs-show 0 0"

echo ":: Checking Shared Drive mount configuration..."

# Ensure mount point exists
if [ ! -d "$MOUNT_POINT" ]; then
    echo "   -> Creating mount point $MOUNT_POINT..."
    sudo mkdir -p "$MOUNT_POINT"
fi

# Check if the device with the given UUID exists
if ! blkid -U "$UUID" > /dev/null 2>&1; then
    echo "   -> Warning: Device with UUID $UUID not found. Skipping mount setup."
    exit 0
fi

# Check if UUID is already in fstab
if grep -q "$UUID" /etc/fstab; then
    echo "   -> Shared Drive entry already exists in /etc/fstab."
else
    echo "   -> Adding Shared Drive entry to /etc/fstab..."
    echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab > /dev/null
    sudo systemctl daemon-reload
    echo "   -> Done."
fi

# Ensure it is mounted
echo "   -> Ensuring the drive is mounted..."
sudo mount -a
