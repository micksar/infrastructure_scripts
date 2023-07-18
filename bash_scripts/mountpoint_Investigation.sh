#!/bin/bash

# Output basic system information
echo "----- System Information -----"
echo "Hostname: $(hostname)"
echo "Kernel Version: $(uname -r)"
echo "Distribution: $(lsb_release -ds)"

# Output storage details
echo "----- Storage Information -----"
df -h

# Prompt for the mountpoint to investigate
read -p "Enter the mountpoint to investigate (e.g., /, /var, /home): " mountpoint

# Verify if the mountpoint exists
if [ ! -d "$mountpoint" ]; then
  echo "Mountpoint does not exist."
  exit 1
fi

# Output disk usage details for the specified mountpoint
echo "----- Disk Usage for $mountpoint -----"
du -h --max-depth=1 "$mountpoint" 2>/dev/null | sort -hr