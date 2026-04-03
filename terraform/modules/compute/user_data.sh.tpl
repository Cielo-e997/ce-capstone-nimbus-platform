#!/bin/bash
set -e

apt update -y
apt install -y python3 python3-pip python3-venv curl

mkdir -p /opt/nimbus-app/src

cat <<EOF >/opt/nimbus-app/src/app.py
from flask import Flask, jsonify
import os

app = Flask(__name__)

PROJECT_NAME = os.getenv("PROJECT_NAME", "Nimbus Platform")
ENVIRONMENT = os.getenv("ENVIRONMENT", "dev")
INSTANCE_ID = os.getenv("INSTANCE_ID", "unknown-instance")
AVAILABILITY_ZONE = os.getenv("AVAILABILITY_ZONE", "unknown-az")
DB_HOST = os.getenv("DB_HOST", "not-configured")


@app.route("/")
def home():
    return f"""
    <html>
      <head>
        <title>{PROJECT_NAME}</title>
      </head>
      <body>
        <h1>{PROJECT_NAME}</h1>
        <p><strong>Environment:</strong> {ENVIRONMENT}</p>
        <p><strong>Instance ID:</strong> {INSTANCE_ID}</p>
        <p><strong>Availability Zone:</strong> {AVAILABILITY_ZONE}</p>
        <p><strong>DB Host:</strong> {DB_HOST}</p>
        <p><strong>Health Status:</strong> healthy</p>
      </body>
    </html>
    """


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy",
        "project_name": PROJECT_NAME,
        "environment": ENVIRONMENT,
        "instance_id": INSTANCE_ID,
        "availability_zone": AVAILABILITY_ZONE,
        "db_host": DB_HOST
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

cat <<EOF >/opt/nimbus-app/requirements.txt
Flask==3.0.3
EOF

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" -s)

INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s \
  http://169.254.169.254/latest/meta-data/instance-id)

AVAILABILITY_ZONE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s \
  http://169.254.169.254/latest/meta-data/placement/availability-zone)

cat <<EOF >/etc/nimbus-app.env
PROJECT_NAME=Nimbus Platform
ENVIRONMENT=${environment}
INSTANCE_ID=$INSTANCE_ID
AVAILABILITY_ZONE=$AVAILABILITY_ZONE

DB_HOST=${db_endpoint}
DB_NAME=nimbus
DB_USER=admin
EOF

python3 -m venv /opt/nimbus-app/venv
source /opt/nimbus-app/venv/bin/activate
pip install --upgrade pip
pip install -r /opt/nimbus-app/requirements.txt

cat <<EOF >/etc/systemd/system/nimbus-app.service
[Unit]
Description=Nimbus Flask Application
After=network.target

[Service]
WorkingDirectory=/opt/nimbus-app
EnvironmentFile=/etc/nimbus-app.env
ExecStart=/opt/nimbus-app/venv/bin/python /opt/nimbus-app/src/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable nimbus-app
systemctl start nimbus-app
