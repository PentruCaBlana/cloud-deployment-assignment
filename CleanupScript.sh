#!/bin/bash

#Cleanup GCP resources to avoid any account charges

VM_NAME="assignment-vm"
ZONE="europe-west2-b"
REGION="europe-west2"
STATIC_IP_NAME="assignment-ip"
FIREWALL_NAME="allow-http-ssh"

echo "Deleting VM..."
gcloud compute instances delete $VM_NAME --zone=$ZONE --quiet

echo "Releasing static IP..."
gcloud compute addresses delete $STATIC_IP_NAME --region=$REGION --quiet

echo "Deleting firewall rule..."
gcloud compute firewall-rules delete $FIREWALL_NAME --quiet

echo "Cleanup Complete, Money Saved"
