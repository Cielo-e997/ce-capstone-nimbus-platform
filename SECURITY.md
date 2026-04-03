# Security 🔐

Nimbus Platform is designed with security as a core principle, following common AWS best practices to minimize exposure and enforce controlled access between components.

---

## 🌐 Network isolation

The infrastructure is deployed inside a custom VPC and separated into multiple subnet layers:

- Public subnets → only for the Application Load Balancer  
- Private application subnets → for EC2 instances  
- Private database subnets → for RDS  

This ensures that only the load balancer is publicly accessible, while the rest of the system remains isolated.

---

## 🧱 Security Groups

Security Groups are used to strictly control traffic between layers:

### ALB Security Group
- Allows inbound HTTP (port 80) from the internet  
- Forwards traffic to EC2 instances  

---

### EC2 Security Group
- Allows inbound traffic only from the ALB  
- No direct public access  

---

### RDS Security Group
- Allows inbound traffic only from EC2 instances  
- Database is not publicly accessible  

---

## 🔒 Principle of least privilege

Each component only has access to what it strictly needs:

- EC2 instances do not expose unnecessary ports  
- RDS is fully isolated from public access  
- Traffic flows only in one direction: ALB → EC2 → RDS  

---

## 🔐 Secrets and configuration

Sensitive or environment-specific values are not hardcoded.

Instead, they are stored in AWS Systems Manager Parameter Store:

- /nimbus/dev/db_host  
- /nimbus/dev/db_name  
- /nimbus/dev/db_user  

This improves security and flexibility.

---

## 🛡️ Instance metadata protection

EC2 instances use IMDSv2 (Instance Metadata Service v2), which protects against SSRF-style attacks by requiring session tokens.

---

## 📊 Monitoring and alerts

Security is reinforced through observability:

- CloudWatch Alarms detect abnormal behavior  
- CPU spikes or ALB errors can indicate issues  

---

## 💰 Cost awareness as security

Budget alerts are configured to detect unusual spending patterns, which can also signal potential misuse or misconfiguration.

---

## 📌 Summary

Security in Nimbus Platform is based on:

- Network isolation (public vs private layers)  
- Controlled communication via Security Groups  
- No direct exposure of application or database  
- Externalized configuration using SSM  
- Continuous monitoring and alerting  

The design minimizes risk while keeping the system scalable and maintainable.