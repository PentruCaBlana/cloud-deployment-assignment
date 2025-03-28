# Cloud Development Platform - Exercise Two

## Project Overview
This project automates the deployment of a virtual machine on Google Cloud Platform (GCP) to host a simple Apache-based web server. The deployment is scripted using Bash and aligns with the infrastructure specifications from Exercise Two of the Cloud Development Platform assignment.

## Files Included
- `DeploymentScript.sh`: Deploys a VM with a static IP, opens firewall ports, and installs Apache to serve a "Hello World" page.
- `CleanupScript.sh`: Deletes all deployed resources to avoid unintended charges.

## Prerequisites
Before running the deployment or cleanup scripts, ensure the following:
- **Google Cloud SDK** is installed and initialized: `gcloud init`
- You are authenticated using your **personal Google account** (not a service account)
- Your account has **Editor** or **Compute Admin** IAM permissions on the GCP project
- Required GCP **APIs are enabled**, including:
  - Compute Engine API
  - IAM API (for managing permissions)
- A valid **billing account** is linked to your GCP project (Free Tier eligible)

## Deployment Specs (Per Assignment Requirements)
- **VM Configuration**: 2 vCPUs, 8 GB RAM
- **Boot Disk**: 250GB
- **OS**: Ubuntu 20.04 LTS
- **Web Server**: Apache2
- **Network**: Static external IP
- **Firewall Rules**: TCP ports 22 (SSH) and 80 (HTTP) open

## Free Tier Testing (For Cost Safety)
While the script is built to meet full assignment specs, testing was done using the following configuration to stay within Google Cloud Free Tier:
- **Machine Type**: e2-micro
- **Disk Size**: 10GB
- **Same startup script and configuration logic**

## Setup Instructions
1. Clone this repository or copy the scripts to your local machine.
2. Make sure the Google Cloud SDK is installed and initialized:
   ```bash
   gcloud init
   ```
3. Replace `your-project-id` in `DeploymentScript.sh` with your actual GCP project ID.
4. Run the deployment script:
   ```bash
   chmod +x DeploymentScript.sh
   ./DeploymentScript.sh
   ```
5. Note the external IP printed by the script and visit it in your browser:
   ```
   http://<EXTERNAL_IP>
   ```

## Cleanup Instructions
To remove all GCP resources created by the deployment script:
```bash
chmod +x CleanupScript.sh
./CleanupScript.sh
```
This will delete:
- The VM instance
- The static IP address
- The firewall rule

## Screenshots for Submission
- Terminal showing successful deployment
- GCP Console showing the running VM instance
- SSH terminal into the VM
- Browser displaying the "Hello World" webpage

## Notes
- Initial web server setup may take 1–2 minutes after deployment
- Firewall rule allows both SSH and HTTP traffic
- No service account is attached to the VM to ensure proper control and avoid permission issues

## Author
Stefan Bordea  
10603822@mydbs.ie

---
This project was completed as part of the Cloud Development Platform module.
All scripts were tested on a Kali Linux VM using the Google Cloud SDK.

