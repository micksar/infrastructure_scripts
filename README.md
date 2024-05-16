# Print all the files and folders on the current dir and sort them descending
du -sh * | sort -hr

# Delete all the docker volumes not used from any container
docker volume prune
