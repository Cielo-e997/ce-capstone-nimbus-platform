# Security Documentation

## Security Principles

Nimbus Platform follows a defense-in-depth approach, applying security controls across multiple layers:

1. **Network security** – Isolation and controlled access between tiers  
2. **Access control** – Least privilege IAM roles  
3. **Data protection** – Encryption in transit and secure secret management  

The goal is to reduce the attack surface while maintaining operational simplicity.

---

## Network Security

### Security Group Configuration

#### Load Balancer Security Group
- Inbound:
  - HTTP (80) from 0.0.0.0/0  
  - HTTPS (443) from 0.0.0.0/0  
- Outbound:
  - Application tier (app port)

---

#### Application Security Group
- Inbound:
  - From ALB security group only  
- Outbound:
  - Database (DB port)
  - Internet (via NAT Gateway)

---

#### Database Security Group
- Inbound:
  - From application security group only  
- Outbound:
  - None  

---

### Network Isolation

- **Database layer** is fully private with no internet access  
- **Application layer** runs in private subnets and cannot be accessed directly  
- **Only the ALB is public-facing**  

This ensures strict separation between external traffic and internal services.

---

## Identity & Access Management

### IAM Roles

- **EC2 Instance Role**
  - Access to SSM Parameter Store
  - Permission to send logs to CloudWatch  

- **CI/CD (GitHub Actions)**
  - Permissions to run Terraform  
  - Scoped to required AWS resources only  

---

### Least Privilege

All IAM roles are designed to include only the permissions strictly required for their function.

No wildcard permissions are used unless necessary.

---

## Secrets Management

- Secrets are stored in **AWS Systems Manager Parameter Store**
- Sensitive values (such as database endpoints or credentials) are **not hardcoded**
- Access is restricted via IAM roles

This ensures secrets are managed securely and centrally.

---

## Encryption

### Data in Transit

- HTTPS enabled via **AWS Certificate Manager (ACM)**
- TLS termination handled at the Application Load Balancer  

---

### Data at Rest

- AWS-managed services (EBS, RDS) use encryption by default  
- No unencrypted storage is intentionally used  

---

## Security Scanning

Security scanning is integrated directly into the CI/CD pipeline.

- **Tool:** Checkov  
- **Scope:** Terraform code  
- **Trigger:** On push and pull requests  
- **Purpose:** Detect misconfigurations before deployment  

This helps prevent insecure infrastructure from being applied.

---

## Monitoring & Detection

- CloudWatch alarms monitor:
  - High CPU usage  
  - Load balancer errors  
  - Unhealthy instances  

- Logs are available for investigation and troubleshooting  

---

## Known Risks & Trade-offs

### Single NAT Gateway

- **Risk:** Single point of failure  
- **Impact:** Loss of outbound connectivity for private resources  
- **Decision:** Accepted to reduce cost in a development environment  

---

### Self-Signed HTTPS Certificate

- **Risk:** Not trusted by browsers  
- **Impact:** Security warning for users  
- **Decision:** Acceptable for demonstration purposes  

---

## Future Security Improvements

- Implement AWS Config or Security Hub for compliance monitoring  
- Add Web Application Firewall (WAF)  
- Enable GuardDuty for threat detection  
- Automate remediation workflows  
- Introduce secrets rotation  

---

This security model reflects real-world practices while balancing complexity, cost, and project scope.