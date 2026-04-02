#!/bin/bash

set -e

echo "Updating system packages..."
sudo apt update -y

echo "Installing Python dependencies..."
sudo apt install -y python3 python3-pip python3-venv

echo "Creating application directory..."
sudo mkdir -p /opt/nimbus-app
sudo chown -R ubuntu:ubuntu /opt/nimbus-app

echo "Copying application files..."
cp -r /home/ubuntu/app/* /opt/nimbus-app/

cd /opt/nimbus-app

echo "Creating virtual environment..."
python3 -m venv venv

echo "Activating virtual environment..."
source venv/bin/activate

echo "Installing Python requirements..."
pip install --upgrade pip
pip install -r requirements.txt

echo "Setting application environment variables..."
cat <<EOF | sudo tee /etc/nimbus-app.env
PROJECT_NAME=Nimbus Platform
ENVIRONMENT=dev
INSTANCE_ID=ec2-instance
AVAILABILITY_ZONE=eu-central-1
EOF

echo "Deployment preparation complete."