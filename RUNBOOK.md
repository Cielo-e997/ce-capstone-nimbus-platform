# Runbook 📘

This runbook provides operational guidance for managing, troubleshooting, and maintaining the Nimbus Platform.

---

## 🚀 Application access

The application is exposed via the Application Load Balancer (ALB).

- Open the ALB DNS in your browser  
- Example output includes:
  - Environment  
  - Instance ID  
  - Availability Zone  
  - DB Host  

Health endpoint:

/health  

---

## 🔍 Basic checks

### 1. Application not loading

Check:

- ALB DNS is correct  
- Instances are running in the Auto Scaling Group  
- Target Group health checks  

AWS Console:

EC2 → Target Groups → Check "Healthy" instances  

---

### 2. Instances unhealthy

Possible causes:

- Application not running  
- User data failed  
- Security group misconfiguration  

Steps:

1. Go to EC2 → Instances  
2. Connect via Session Manager (if enabled)  
3. Check service status:

sudo systemctl status nimbus-app  

4. Restart if needed:

sudo systemctl restart nimbus-app  

---

### 3. High CPU usage

Triggered by CloudWatch Alarm: nimbus-high-cpu

Actions:

- Check instance metrics in CloudWatch  
- Verify traffic load  
- Scale out manually (if needed):

aws autoscaling set-desired-capacity 
  --auto-scaling-group-name nimbus-dev-asg 
  --desired-capacity 3  

---

### 4. ALB 5XX errors

Triggered by alarm: nimbus-alb-5xx-errors

Possible causes:

- App crash  
- Instances failing health checks  

Steps:

- Check Target Group health  
- Review application logs:

journalctl -u nimbus-app  

---

### 5. Database connectivity issues

Check:

- RDS instance status → "Available"  
- Security group allows traffic from EC2  
- DB endpoint is correct  

Verify from app instance:

ping <db-endpoint>  

---

## 🔄 Deployment updates

When updating application or user_data:

1. Apply Terraform changes:

terraform apply  

2. Trigger instance refresh:

aws autoscaling start-instance-refresh 
  --auto-scaling-group-name nimbus-dev-asg 
  --region eu-central-1  

3. Monitor progress:

aws autoscaling describe-instance-refreshes 
  --auto-scaling-group-name nimbus-dev-asg 
  --region eu-central-1  

---

## 📊 Monitoring

Use CloudWatch:

- Dashboards → system overview  
- Alarms → active alerts  

Key metrics:

- CPUUtilization  
- HTTPCode_ELB_5XX  
- TargetResponseTime  

---

## 💰 Cost monitoring

- Check AWS Budgets dashboard  
- Alerts trigger when approaching limits  

---

## 🔐 Configuration management

Stored in SSM Parameter Store:

- /nimbus/dev/db_host  
- /nimbus/dev/db_name  
- /nimbus/dev/db_user  

---

## 🧯 Emergency actions

If system is unstable:

- Restart instances:

aws autoscaling start-instance-refresh  

- Reduce traffic (if needed)  
- Investigate logs before scaling further  

---

## 📌 Final note

This runbook is designed for quick reaction during incidents.  
Always prioritize identifying the root cause before applying fixes.