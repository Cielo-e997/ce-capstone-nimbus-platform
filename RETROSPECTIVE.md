# Retrospective 🧠

This project was a full end-to-end exercise in designing and deploying a production-like system on AWS. It went beyond simply creating resources — it required understanding how different components interact, fail, and scale together.

---

## 🎯 What went well

One of the strongest aspects of this project was achieving a complete, working architecture that mirrors real-world setups:

- Multi-AZ infrastructure with proper network segmentation  
- Load balancing and auto scaling working together  
- A private database layer integrated with the application  
- Observability through dashboards and alarms  
- Cost awareness with budget alerts  

Everything was not only deployed, but also connected and functioning as a system.

---

## 🧩 Challenges faced

Several challenges came up during the process:

- Understanding how Terraform modules interact and pass data between each other  
- Debugging user_data scripts and ensuring EC2 instances boot correctly  
- Managing updates through launch templates and instance refresh  
- Ensuring security groups allowed the correct traffic while still remaining restrictive  
- Connecting the application to the database without exposing sensitive data  

These issues required iteration, troubleshooting, and careful validation.

---

## 🛠️ How I solved them

- Broke down the infrastructure into smaller, modular components  
- Used Terraform plan and apply cycles to validate each step  
- Leveraged AWS CLI and console together to debug issues  
- Implemented rolling updates via Auto Scaling instead of manual fixes  
- Verified each layer independently (network → compute → database → app)  

---

## 📚 What I learned

This project reinforced several key concepts:

- Infrastructure as Code is not just about writing Terraform — it's about designing systems  
- Observability is essential, not optional  
- Security should be built into the architecture from the beginning  
- Small misconfigurations (like security groups or user_data) can break the entire system  
- Cost awareness is a critical part of cloud engineering  

---

## 🔄 What I would improve

If I had more time, I would extend the project with:

- Full integration with SSM Parameter Store in the application (instead of static values)  
- HTTPS support using ACM and ALB  
- CI/CD pipeline for automated deployments  
- Database backups and multi-AZ configuration  
- More detailed logging and tracing  

---

## 💡 Final thoughts

This project helped me move from “learning AWS services” to actually thinking like a cloud engineer.

Instead of focusing on individual tools, I focused on how everything works together as a system.

The biggest takeaway is that building infrastructure is not just about making it work — it's about making it reliable, observable, and maintainable.