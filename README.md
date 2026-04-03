# Nimbus Platform

Building a production-ready cloud platform from scratch was the goal of this project. The idea wasn’t just to deploy infrastructure, but to bring together everything learned throughout the bootcamp into a system that actually behaves like something you’d see in a real environment.

Nimbus is a multi-tier application platform running on AWS, designed with scalability, observability, security, and automation in mind.

---

## 🌍 What this project is about

Nimbus Platform simulates a real-world cloud environment where an application is deployed behind a load balancer, scaled automatically, monitored continuously, and managed through Infrastructure as Code.

Instead of focusing on application complexity, the emphasis is on **infrastructure quality, reliability, and operational practices**.

This is the kind of system you would expect to maintain as a cloud engineer.

---

## 🧱 Architecture overview

At a high level, the system follows a classic multi-tier architecture:

- A public-facing **Application Load Balancer (ALB)** handles incoming traffic
- Application instances run inside an **Auto Scaling Group across multiple AZs**
- The application tier lives in **private subnets**, isolated from direct internet access
- A **managed RDS database** provides persistent storage
- A **NAT Gateway** allows outbound connectivity from private resources

Traffic flows through the system in a controlled and secure way, ensuring both availability and isolation between components.

HTTPS is enabled at the load balancer level using AWS Certificate Manager, so all external communication is encrypted.

---

## ⚙️ Infrastructure as Code

The entire platform is defined using Terraform.

The codebase is modular and structured to reflect real-world practices:

- Separate modules for networking, compute, and database
- Reusable components
- Clear variable and output definitions
- Remote state management

This makes the infrastructure predictable, reproducible, and easy to extend.

---

## 🚀 Deployment approach

Infrastructure is deployed through Terraform, but everything is tied into a CI/CD workflow using GitHub Actions.

Every change goes through:

- Validation
- Formatting checks
- Security scanning
- Deployment on merge

This ensures that infrastructure changes are controlled, reviewed, and automated — just like in a real engineering team.

---

## 🔄 CI/CD and automation

The platform uses GitHub Actions to automate key workflows:

- Terraform validation and formatting
- Infrastructure planning
- Deployment on changes to the main branch
- Security scanning using Checkov

By integrating security directly into the pipeline, misconfigurations can be caught early before reaching production.

---

## 📊 Observability and monitoring

Monitoring is implemented using AWS CloudWatch.

A custom dashboard provides visibility into the system’s health, including:

- CPU utilization
- Traffic patterns
- Error rates
- Resource usage

Alerts are configured to detect issues such as:

- High CPU usage
- Load balancer errors
- Unhealthy application instances

This allows quick identification and response to potential problems.

---

## 🔐 Security considerations

Security was approached as a layered system:

- Network isolation using public and private subnets
- Security groups restricting access between tiers
- IAM roles following the principle of least privilege
- Secrets stored in AWS Systems Manager Parameter Store
- No hardcoded credentials in code

Additionally, security scanning is integrated into the CI/CD pipeline using Checkov, helping detect infrastructure misconfigurations automatically.

---

## 🔒 HTTPS and encryption

To simulate production-grade behavior, HTTPS was implemented using AWS Certificate Manager.

The Application Load Balancer terminates TLS and forwards traffic securely to the application layer.

Even though a self-signed certificate is used for demonstration purposes, the architecture mirrors how secure traffic is handled in real environments.

---

## 💰 Cost awareness

Cost optimization was considered throughout the project:

- Instance types were chosen based on expected load
- A single NAT Gateway was used to balance cost and availability
- Resource tagging was implemented for cost tracking
- Budget awareness was maintained during deployment

The goal wasn’t just to build something that works, but something that makes sense financially.

---

## 🧠 Design decisions

Several trade-offs were made during the project:

- EC2 was chosen over containers for simplicity and control
- A single NAT Gateway was used to reduce cost, accepting limited redundancy
- Self-signed certificates were used for HTTPS to avoid domain dependency
- Monitoring was kept simple but effective using CloudWatch

Each decision reflects a balance between complexity, cost, and learning objectives.

---

## 🛠️ Tech stack

- Terraform
- AWS (EC2, ALB, RDS, VPC, CloudWatch, ACM)
- GitHub Actions
- Checkov (security scanning)
- Bash (user data scripts)

---

## 🚧 What I would improve next

If this were to evolve further, the next steps would be:

- Containerizing the application and moving to ECS
- Implementing multi-region disaster recovery
- Adding AWS WAF for application protection
- Introducing distributed tracing for deeper observability
- Automating remediation for security findings

---

## 👤 Author

Cielo Escobar  
Cloud Engineering Bootcamp  

---

This project represents the integration of everything learned during the program — not just technically, but also in terms of thinking like an engineer: making decisions, understanding trade-offs, and building systems that are maintainable and scalable.