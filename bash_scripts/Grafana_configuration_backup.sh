#!/bin/bash

# Declare the AWS S3 bucket. Pass that as an environment variable on the server
S3_BUCKET=${your_s3_bucket_name}

# Declare the directories of your Grafana configurations and data
GRAFANA_DIR="./configs/grafana"
GRAFANA_DATA_DIR="/var/lib/docker/volumes/docker_grafana-data/_data"

# Create a backup directory
BACKUP_DIR="grafana_backup_$(date +'%Y_%m_%d_%H_%M_%S')"
mkdir $BACKUP_DIR

# Copy the Grafana configurations and data to the backup directory
cp -r $GRAFANA_DIR $BACKUP_DIR/
cp -r $GRAFANA_DATA_DIR $BACKUP_DIR/grafana-data

# Compress the backup directory
tar -czvf $BACKUP_DIR.tar.gz $BACKUP_DIR/

# Upload to AWS S3
aws s3 cp $BACKUP_DIR.tar.gz s3://$S3_BUCKET/

# Optional: Remove local backup files after successful upload
rm -rf $BACKUP_DIR/
rm $BACKUP_DIR.tar.gz