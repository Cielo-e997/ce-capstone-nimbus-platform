# Architecture Overview 🏗️

Nimbus Platform is designed following a typical production-ready AWS architecture with separation of concerns, high availability, and security best practices.

---

## 🌍 High-level design

The system is built inside a custom VPC and split across public and private subnets:

- Public layer → Load Balancer  
- Private application layer → EC2 instances (Auto Scaling Group)  
- Private data layer → RDS MySQL  

This ensures that only the load balancer is exposed to the internet, while the application and database remain protected.

---

## 🧱 Core components

### 1. Networking

- Custom VPC  
- 2 Public Subnets (Multi-AZ)  
- 2 Private App Subnets  
- 2 Private DB Subnets  
- Internet Gateway (for public access)  
- NAT Gateway (for outbound access from private subnets)  

---

### 2. Compute Layer

- Auto Scaling Group (ASG)
- Launch Template
- EC2 instances running a Flask application

Instances are deployed in private subnets and receive traffic only through the ALB.

---

### 3. Load Balancer

- Application Load Balancer (ALB)
- Public-facing
- Routes traffic to EC2 instances in the ASG
- Performs health checks

---

### 4. Database Layer

- Amazon RDS (MySQL)
- Deployed in private DB subnets
- Not publicly accessible
- Accessible only from application security group

---

### 5. Security

Security Groups are used to strictly control traffic:

- ALB → allows HTTP from internet  
- EC2 → allows traffic only from ALB  
- RDS → allows traffic only from EC2  

This enforces a clear security boundary between layers.

---

## 🔄 Data flow

1. User accesses the application via the ALB  
2. ALB routes the request to EC2 instances  
3. EC2 application processes request  
4. (Optional) Application connects to RDS  
5. Response is returned to the user  

---

## 📊 Observability

- CloudWatch Dashboard for system visibility  
- CloudWatch Alarms for:
  - High CPU usage  
  - ALB 5XX errors  

---

## 💰 Cost control

- AWS Budget configured to monitor monthly spending  
- Alerts trigger when thresholds are exceeded  

---

## 🔐 Configuration

- SSM Parameter Store used to store:
  - Database host  
  - Database name  
  - Database user  

This avoids hardcoding sensitive values.

---

## ⚙️ Design decisions

- Private subnets for application and database → improved security  
- ALB instead of direct EC2 access → scalability + abstraction  
- Auto Scaling Group → resilience and elasticity  
- Modular Terraform structure → maintainability  

---

## 📌 Summary

This architecture mirrors real production environments by combining:

- Security (network isolation + SG rules)  
- Scalability (ASG + ALB)  
- Reliability (Multi-AZ setup)  
- Observability (CloudWatch)  
- Cost awareness (Budgets)  

The goal is not just deployment, but understanding how a cloud system behaves end-to-end