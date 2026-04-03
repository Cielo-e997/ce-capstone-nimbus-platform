# Nimbus Platform ☁️

Nimbus Platform is a production-style cloud infrastructure built on AWS using Terraform. The goal of this project was to design and deploy a scalable, observable, and cost-aware application environment that reflects real-world architecture patterns.

---

## 🚀 What this project does

This platform runs a simple web application behind an Application Load Balancer, backed by an Auto Scaling Group and connected to a private RDS database.

It includes:

- Multi-AZ infrastructure for high availability  
- Auto Scaling for resilience and elasticity  
- A private database layer (RDS)  
- Monitoring and alerting using CloudWatch  
- Cost control with AWS Budgets  
- Configuration management via SSM Parameter Store  

---

## 🏗️ Architecture overview

- VPC with public and private subnets  
- Internet Gateway + NAT Gateway  
- Application Load Balancer (public)  
- Auto Scaling Group (private subnets)  
- RDS MySQL instance (private subnets)  
- Security Groups controlling traffic flow  

---

## 📊 Observability

- CloudWatch Dashboard tracking key metrics  
- Alarms configured for:
  - High CPU usage  
  - ALB 5XX errors  

---

## 💰 Cost control

- Monthly AWS Budget configured with alerts  
- Helps prevent unexpected costs  

---

## 🔐 Configuration management

- Sensitive and dynamic values stored in SSM Parameter Store:
  - Database host  
  - Database name  
  - Database user  

---

## 🌐 Application

A simple Flask app that displays:

- Environment  
- Instance ID  
- Availability Zone  
- Database endpoint  
- Health status  

---

## 📸 Screenshots

Located in:

presentation/screenshots/

Includes:

- Running application  
- CloudWatch dashboard  
- RDS instance  
- Alarms  
- Budget  
- SSM parameters  

---

## 🧠 Why I built this

The goal was to simulate a real-world production environment and demonstrate:

- Infrastructure as Code (Terraform)  
- AWS architecture design  
- Observability and monitoring  
- Cost awareness  
- Clean modular structure  

---

## ⚙️ How to run

cd terraform  
terraform init  
terraform apply  

---

## 📌 Final note

This project is not just about deploying resources — it's about understanding how systems behave in production: scaling, failing, recovering, and being monitore