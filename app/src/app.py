from flask import Flask, jsonify
import os

app = Flask(__name__)

PROJECT_NAME = os.getenv("PROJECT_NAME", "Nimbus Platform")
ENVIRONMENT = os.getenv("ENVIRONMENT", "dev")
INSTANCE_ID = os.getenv("INSTANCE_ID", "local-instance")
AVAILABILITY_ZONE = os.getenv("AVAILABILITY_ZONE", "local-az")


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
        "availability_zone": AVAILABILITY_ZONE
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)