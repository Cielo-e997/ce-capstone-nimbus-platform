# Architecture Documentation

## System Overview

### Purpose

Nimbus Platform is a production-ready cloud infrastructure designed to simulate a real-world application environment. It focuses on high availability, scalability, observability, and security using AWS services and Infrastructure as Code.

### Design Goals

- High availability through multi-AZ deployment  
- Clear separation of concerns across tiers  
- Secure network architecture with private subnets  
- Automated infrastructure management via Terraform  
- Observability through monitoring and alerting  
- Cost-aware design decisions  

### Constraints

- Single AWS region deployment  
- Limited time (1-week implementation)  
- Focus on infrastructure over application complexity  
- No domain ownership (self-signed HTTPS used)  

---

## Architecture Overview

The platform follows a **three-tier architecture**:

1. **Presentation Layer**
   - Application Load Balancer (ALB)
   - Handles HTTP and HTTPS traffic
   - Publicly accessible

2. **Application Layer**
   - EC2 instances managed by Auto Scaling Group
   - Deployed across multiple Availability Zones
   - Runs the application logic

3. **Data Layer**
   - Amazon RDS instance
   - Hosted in private subnets
   - Not publicly accessible

Traffic flows from the internet into the ALB, which distributes requests to healthy instances in the application tier.

---

## Components

### Application Load Balancer (ALB)

- **Purpose:** Distribute incoming traffic across application instances  
- **Type:** Internet-facing  
- **Subnets:** Public subnets in multiple AZs  
- **Listeners:**
  - HTTP (port 80)
  - HTTPS (port 443)  
- **SSL:** AWS ACM (self-signed certificate)  

**Rationale:**  
ALB was chosen for its support of HTTP/HTTPS routing and integration with health checks and auto scaling.

---

### Application Tier

- **Compute:** EC2 instances  
- **Scaling:** Auto Scaling Group  
- **Deployment:** Launch Template with user data  
- **Location:** Private subnets  

**Rationale:**  
EC2 provides full control over the environment and simplifies deployment without requiring containerization.

---

### Database Layer

- **Service:** Amazon RDS  
- **Location:** Private subnets  
- **Access:** Only from application security group  

**Rationale:**  
Managed database service reduces operational overhead and improves reliability.

---

### Networking

- **VPC:** Custom VPC with segmented subnets  
- **Subnets:**
  - Public (ALB)
  - Private (application)
  - Private (database)
- **NAT Gateway:** Enables outbound access from private subnets  
- **Internet Gateway:** Provides internet access to public subnets  

---

## Network Design

### Subnet Strategy

| Tier        | Subnet Type | Access        |
|-------------|------------|--------------|
| ALB         | Public     | Internet     |
| Application | Private    | Internal only|
| Database    | Private    | Internal only|

---

### Security Groups

- **ALB Security Group**
  - Inbound: HTTP/HTTPS from internet
  - Outbound: Application tier

- **Application Security Group**
  - Inbound: From ALB only
  - Outbound: Database + internet (via NAT)

- **Database Security Group**
  - Inbound: From application tier only
  - No public access

---

## Data Flow

### HTTP Flow

1. User sends request to ALB  
2. ALB receives request in public subnet  
3. ALB forwards request to healthy instance  
4. Application processes request  
5. Optional database interaction  
6. Response returned via ALB  

---

### HTTPS Flow

1. User connects via HTTPS  
2. ALB terminates TLS using ACM certificate  
3. Traffic forwarded securely to application instances  
4. Application processes request  
5. Response returned to user  

---

## Design Decisions

### Decision: EC2 vs Containers

**Chosen:** EC2  

**Reasoning:**
- Simpler setup within project timeline  
- Full control over environment  
- No need for container orchestration complexity  

**Trade-off:**
- Less efficient than containers  
- Manual scaling configuration  

---

### Decision: Single NAT Gateway

**Chosen:** Single NAT  

**Reasoning:**
- Reduces cost  
- Acceptable for development environment  

**Trade-off:**
- Single point of failure  
- Reduced availability in edge cases  

---

### Decision: Self-Signed HTTPS

**Chosen:** Self-signed ACM certificate  

**Reasoning:**
- No domain required  
- Enables demonstration of HTTPS architecture  

**Trade-off:**
- Browser warning  
- Not production-grade trust  

---

## High Availability Strategy

- Multi-AZ deployment for application tier  
- Load balancer distributes traffic across instances  
- Health checks ensure only healthy instances receive traffic  
- Auto Scaling replaces failed instances  

---

## Scalability

- Horizontal scaling via Auto Scaling Group  
- Load balancer handles traffic distribution  
- Architecture supports increased traffic with minimal changes  

---

## Observability

- CloudWatch dashboard for system metrics  
- Alerts for:
  - High CPU usage  
  - ALB errors  
  - Unhealthy instances  
- Logs available for troubleshooting  

---

## Future Improvements

- Multi-region deployment for disaster recovery  
- Containerization with ECS or EKS  
- Web Application Firewall (WAF)  
- Advanced monitoring (tracing / APM)  
- Automated remediation for alerts  

---

This architecture reflects real-world cloud design principles, balancing simplicity, cost, and scalability while demonstrating production-ready patterns.