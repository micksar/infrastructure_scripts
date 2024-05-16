#!/bin/bash

# Initialize total storage usage
total_usage=0

# Get a list of Docker volumes
volumes=$(docker volume ls --format '{{.Name}}')

# Loop through each volume
for volume in $volumes; do
    # Check if the volume is used by any running container
    if ! docker ps --format '{{json .Mounts}}' | grep -q "\"Name\":\"$volume\""; then
        # Get the mount point of the volume
        mountpoint=$(docker volume inspect --format '{{.Mountpoint}}' $volume)

        # Calculate the storage usage of the volume
        usage=$(du -sh $mountpoint | awk '{print $1}')

        # Print the volume name and its storage usage
        echo "Volume: $volume, Storage Usage: $usage"

        # Accumulate the storage usage
        total_usage=$((total_usage + $(du -s $mountpoint | awk '{print $1}')))
    fi
done

# Print the summary of total unused storage
echo "Total Unused Storage: $total_usage"