# Costs 💰

Managing cloud costs was an important part of building Nimbus Platform. The goal was not only to deploy infrastructure, but also to keep it efficient and predictable.

---

## 📊 Cost strategy

The platform was designed with cost-awareness in mind:

- Use of small instance types (t3.micro / db.t3.micro)  
- Minimal resource sizing for a development environment  
- Avoid unnecessary services or over-provisioning  

---

## 💡 Key cost drivers

The main components contributing to cost are:

- EC2 instances (Auto Scaling Group)  
- RDS MySQL instance  
- NAT Gateway (notable cost even in low traffic environments)  
- Application Load Balancer  

Among these, the NAT Gateway and RDS tend to be the most significant in a small setup.

---

## 📉 Cost control measures

### 1. AWS Budget

A monthly budget was configured:

- Budget name: nimbus-monthly-budget  
- Limit: $10  
- Alert threshold: 80%  

This helps detect unexpected cost increases early.

---

### 2. Right-sizing

- EC2 instances use lightweight configurations  
- RDS uses a micro instance  
- No multi-AZ database (to reduce cost in this environment)  

---

### 3. Minimal scaling

- Auto Scaling is configured but not aggressively scaling  
- Keeps cost stable while still demonstrating the concept  

---

## ⚠️ Potential cost risks

Even small environments can generate costs:

- NAT Gateway hourly charges  
- RDS running continuously  
- Load Balancer hourly + LCU usage  

These are important to monitor in real-world scenarios.

---

## 📈 Monitoring

Costs are monitored through:

- AWS Budgets dashboard  
- Billing console  
- Budget alert notifications  

---

## 🧠 Lessons learned

- Cloud resources generate cost even when idle  
- Networking components (like NAT Gateway) can be unexpectedly expensive  
- Budget alerts are essential for early visibility  
- Designing with cost in mind is as important as designing for performance  

---

## 📌 Summary

Nimbus Platform demonstrates:

- Awareness of cost drivers  
- Practical budget monitoring  
- Conscious resource sizing  

The goal is not just to build infrastructure, but to build it responsibly.