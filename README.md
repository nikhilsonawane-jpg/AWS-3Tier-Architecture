# AWS 3-Tier Architecture Project

## 📌 Overview
This project demonstrates the design, deployment, testing, and cleanup of a **production-style 3-tier architecture on AWS** using core cloud services.  
The architecture follows **best practices for security, scalability, high availability, and cost optimization**.

---

## 🏗️ Architecture Diagram
![Architecture](architecture/aws-3tier-diagram.png)

> High-level view of a secure, scalable AWS 3-tier architecture deployed across multiple Availability Zones.

---
### Diagram Explanation
- Public subnets host the Application Load Balancer
- Private app subnets host EC2 instances in an Auto Scaling Group
- Private DB subnets host Amazon RDS
- NAT Gateway provides outbound internet access for private resources

## Request Flow

1. A user sends an HTTP request to the Application Load Balancer (public endpoint).
2. The ALB receives traffic via the Internet Gateway.
3. ALB forwards requests to healthy EC2 instances in private application subnets.
4. EC2 instances process the request and communicate with the RDS database in private DB subnets.
5. RDS responds only to application instances via security group rules.
6. Responses are sent back to the user through the ALB.
7. Outbound internet access for private instances is handled via NAT Gateway.

## 🧱 Architecture Components

### 1️⃣ Networking Layer
- Custom VPC with CIDR
- Public and private subnets across multiple AZs
- Internet Gateway for public access
- NAT Gateway for outbound internet access from private subnets
- Route tables configured per subnet type

### 2️⃣ Application Layer
- Application Load Balancer (ALB) in public subnets
- EC2 instances launched via Launch Template
- Auto Scaling Group across private subnets
- User-data script for automated application setup

### 3️⃣ Database Layer
- Amazon RDS (MySQL/PostgreSQL)
- Private DB subnets using DB Subnet Group
- No public access
- Security group restricted to application tier only

---

## 🔐 Security Design
- Least privilege security groups
- No public IPs for EC2 or RDS
- SSH access only via Bastion host (temporary)
- ALB as the only internet-facing component

---

## 📈 Scalability & High Availability
- Auto Scaling Group with CPU-based target tracking
- Multi-AZ deployment
- Self-healing EC2 instances
- Load balancing via ALB health checks

---

## 📊 Monitoring & Alerting
- CloudWatch metrics for EC2 & ASG
- CPU utilization alarms
- SNS email notifications for alerts
- Stress testing performed to validate alarms and scaling

---

## 🧪 Testing Performed
- Verified private subnet isolation
- Tested ALB health check failures
- Simulated CPU stress to trigger Auto Scaling
- Validated scale-in and scale-out behavior
- Confirmed SNS alert delivery
- Tested instance failure and self-healing

---

## 💰 Cost Optimization
- Free Tier–eligible instance types
- Auto Scaling prevents over-provisioning
- Resources cleaned up after testing to avoid charges

---

## 🧠 Challenges & Learnings
- Understood CloudWatch metric delays and aggregation
- Learned differences between per-instance and ASG-level metrics
- Debugged ALB target health issues
- Gained hands-on experience with real-world scaling behavior

---

## 🛠️ AWS Services Used
- VPC
- EC2
- Auto Scaling
- Application Load Balancer
- RDS
- IAM
- CloudWatch
- SNS

---

## 🧹 Cleanup
All resources were deleted in dependency-aware order to prevent orphaned infrastructure and unnecessary costs.
