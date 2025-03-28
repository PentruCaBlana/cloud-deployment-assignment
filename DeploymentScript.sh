#!/bin/bash

PROJECT_ID="assignmentcloud-455116"
ZONE="europe-west2-b"
REGION="europe-west2"
VM_NAME="assignment-vm"
STATIC_IP_NAME="assignment-ip"
FIREWALL_NAME="allow-http-ssh"
IMAGE_FAMILY="ubuntu-2004-lts"
IMAGE_PROJECT="ubuntu-os-cloud"

# Production Specs (commented out to avoid charges)
# MACHINE_TYPE="n2-standard-2"    # 2 vCPU, 8 GB RAM
# DISK_SIZE="250"                 # 250 GB boot disk

# Free Tier Testing Specs (active)
MACHINE_TYPE="e2-micro"          # Free tier eligible
DISK_SIZE="10"                   # 10 GB disk (under 30 GB free tier limit)

# ---------------------------------------------
echo "Setting project: $PROJECT_ID"
gcloud config set project $PROJECT_ID

# Reserve static external IP
echo "Creating static IP address: $STATIC_IP_NAME"
gcloud compute addresses create $STATIC_IP_NAME \
  --region=$REGION

# Create firewall rule (if not exists)
echo "Creating firewall rule: $FIREWALL_NAME"
gcloud compute firewall-rules create $FIREWALL_NAME \
  --allow=tcp:22,tcp:80 \
  --target-tags=http-server \
  --description="Allow SSH and HTTP access"

# Create the VM instance
echo "Creating VM instance: $VM_NAME"
gcloud compute instances create $VM_NAME \
  --zone=$ZONE \
  --machine-type=$MACHINE_TYPE \
  --image-family=$IMAGE_FAMILY \
  --image-project=$IMAGE_PROJECT \
  --boot-disk-size=${DISK_SIZE}GB \
  --tags=http-server \
  --no-service-account\
  --no-scopes \
  --address=$STATIC_IP_NAME \
  --metadata=startup-script='#! /bin/bash
    apt-get update
    apt-get install -y apache2
    echo "<h1>Hello World from $HOSTNAME</h1>" > /var/www/html/index.html
    systemctl restart apache2'

# Output external IP
echo "Fetching external IP:"
gcloud compute addresses describe $STATIC_IP_NAME \
  --region=$REGION \
  --format="value(address)"

# ---------------------------------------------
echo "Deployment complete. Access your VM via browser using the IP above."
echo "Remember to delete resources when you're done to avoid charges."

