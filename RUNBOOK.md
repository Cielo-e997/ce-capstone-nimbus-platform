# Operations Runbook

## Overview

This runbook provides operational guidance for deploying, managing, and troubleshooting the Nimbus Platform.

It is intended to simulate real-world operational procedures for a cloud-based system.

---

## Deployment

### Initial Deployment

```bash
git clone https://github.com/Cielo-e997/ce-capstone-nimbus-platform.git
cd ce-capstone-nimbus-platform/terraform

terraform init
terraform plan
terraform apply
```

---

### Updating Infrastructure

```bash
terraform plan
terraform apply
```

All infrastructure changes should ideally go through the CI/CD pipeline via GitHub Actions.

---

## Accessing the Application

After deployment, the application is available via the Application Load Balancer:

- HTTP: http://<alb-dns>
- HTTPS: https://<alb-dns>

Note: HTTPS uses a self-signed certificate, so browsers may show a warning.

---

## Monitoring

### Key Health Indicators

- Application health endpoint: `/health` → should return 200 OK  
- Instance health: Verified via ALB target group  
- CPU utilization: Should remain under normal thresholds  
- Error rate: Should remain low  

---

### CloudWatch Dashboard

The system includes a custom dashboard displaying:

- CPU usage  
- Request patterns  
- Error rates  
- Resource utilization  

---

### Alerts

| Alert | Trigger | Action |
|------|--------|--------|
| High CPU | >70% | Check scaling / load |
| ALB 5XX Errors | >1 error | Investigate application |
| Unhealthy Targets | >1 | Check instance health |

---

## Common Operations

### Scaling

Scaling is handled automatically via Auto Scaling Group.

Manual adjustments (if needed):

- Increase desired capacity  
- Adjust min/max limits  

---

### Rolling Updates

To update the application:

1. Modify launch template or user data  
2. Apply Terraform changes  
3. Auto Scaling replaces instances gradually  

---

## Troubleshooting

### Issue: Application Not Responding

Check:

1. ALB target health  
2. EC2 instance status  
3. Security group rules  
4. Application logs  

Possible causes:

- Health check endpoint failing  
- Application crash  
- Misconfigured security groups  

---

### Issue: Unhealthy Targets

Check:

- `/health` endpoint is working  
- Application is running  
- Correct port configuration  

---

### Issue: High CPU Usage

Check:

- Traffic spikes  
- Application performance  
- Scaling behavior  

---

### Issue: HTTPS Not Working

Check:

- ALB listener on port 443  
- ACM certificate attached  
- Correct DNS used  

---

## Incident Response

### Full Outage

1. Check ALB health  
2. Verify instances are running  
3. Check recent Terraform changes  
4. Review CloudWatch metrics  
5. Roll back if needed  

---

### Degraded Performance

1. Check CPU and memory  
2. Review logs  
3. Verify database connectivity  
4. Adjust scaling if needed  

---

## Backup & Recovery

- Infrastructure is fully defined in Terraform → can be recreated  
- Database relies on AWS-managed backups  
- Code stored in GitHub  

---

## Maintenance

- Apply infrastructure changes via Terraform  
- Monitor CloudWatch regularly  
- Keep dependencies updated  

---

## Disaster Recovery

### Strategy

- Re-deploy infrastructure via Terraform  
- Restore database from snapshot  

### Targets

- RTO (Recovery Time Objective): Few hours  
- RPO (Recovery Point Objective): Depends on DB backup frequency  

---

## Notes

This runbook reflects a simplified but realistic operational model, focusing on clarity and practical usage rather than over-engineering.