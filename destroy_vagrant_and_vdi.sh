#!/bin/bash

# Define the path to VBoxManage (adjust the path based on your VirtualBox installation)
VBOXMANAGE="/c/Program Files/Oracle/VirtualBox/VBoxManage"

# Define the VDI name to delete
VDI_NAME="my_box.vdi"

# Find the UUID of the VDI
VDI_UUID=$("$VBOXMANAGE" list hdds | grep "$VDI_NAME" | awk '{print $2}')

if [[ -n "$VDI_UUID" ]]; then
  # Destroy the Vagrant VM (forceful)
  vagrant destroy -f
  
  # Unregister and delete the VDI
  "$VBOXMANAGE" closemedium disk "$VDI_UUID" --delete
  echo "Deleted VDI with UUID $VDI_UUID"
else
  echo "VDI not found: $VDI_NAME"
fi
