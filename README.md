# 🚀 Strapi ECS Deployment with Terraform & GitHub Actions

This project demonstrates a **production-style deployment pipeline** for a Strapi application using:

- Docker
    
- AWS ECS Fargate
    
- AWS ECR
    
- Terraform (Infrastructure as Code)
    
- GitHub Actions (CI/CD)
    
- CloudWatch logging
    
- VPC networking & security groups
    

The system builds, pushes, and deploys a containerized Strapi app automatically.

---

# 🧠 Architecture Overview

```
Developer Push → GitHub
        ↓
GitHub Actions CI/CD
        ↓
Docker Build
        ↓
Push to Amazon ECR
        ↓
Terraform Deploy
        ↓
AWS ECS Fargate Service
        ↓
Strapi Container Running
        ↓
Logs → CloudWatch
```

---

# 🏗 Infrastructure Components

## ✅ AWS ECS (Fargate)

Runs the Strapi container without managing servers.

## ✅ Amazon ECR

Stores Docker images securely.

## ✅ VPC & Networking

Provides secure cloud networking.

- Custom VPC
    
- Public subnets
    
- Internet Gateway
    
- Route tables
    
- Security group (internet access)
    

## ✅ IAM Role

Allows ECS tasks to:

- Pull images from ECR
    
- Send logs to CloudWatch
    

## ✅ CloudWatch Logs

Centralized logging for container output.

## ✅ Terraform Remote State (S3)

Stores infrastructure state safely for CI/CD runs.

---

# 📦 Application Container

Strapi is containerized using Docker.

### Dockerfile

- Node 20 Alpine
    
- installs dependencies
    
- builds Strapi admin
    
- runs production server
    

---

# ⚙️ CI/CD Pipeline (GitHub Actions)

Workflow automatically:

### 1️⃣ Authenticates to AWS

### 2️⃣ Builds Docker image

### 3️⃣ Pushes image to ECR

### 4️⃣ Runs Terraform to deploy/update ECS

Triggered on push to `main`.

---

# 🌐 Networking Design

### VPC

Custom VPC created for isolation.

### Public Subnets

ECS tasks run in public subnets with public IP.

### Security Group

Allows:

- inbound: port 1337 (Strapi)
    
- outbound: full internet access
    

This enables:

✔ pulling images from ECR  
✔ accessing AWS APIs  
✔ internet connectivity

---

# 📊 Logging

CloudWatch Log Group:

```
/ecs/strapi
```

Logs include:

- container startup
    
- errors
    
- runtime output
    

---

# 🔐 Environment Variables

Configured in ECS task definition:

- NODE_ENV
    
- APP_KEYS
    
- API_TOKEN_SALT
    
- ADMIN_JWT_SECRET
    
- JWT_SECRET
    

These are required for Strapi to run in production.

---

# 🚀 Deployment Flow

## Step 1: Push Code

```
git push origin main
```

## Step 2: CI/CD Executes

✔ Docker image built  
✔ Image pushed to ECR  
✔ Terraform updates ECS

## Step 3: ECS launches container

## Step 4: Access app

```
http://<PUBLIC-IP>:1337
http://<PUBLIC-IP>:1337/admin
```

---

# 🧪 Troubleshooting Guide

## ❌ ECS task stops immediately

Check:

```
ECS → Task → Logs
```

Common causes:

### Missing environment variables

Strapi requires secrets to start.

### Database config issues

Default SQLite works; external DB requires config.

---

## ❌ Cannot pull image from ECR

Ensure:

- task execution role exists
    
- outbound internet access enabled
    
- security group allows egress
    

---

## ❌ Logs not appearing

Ensure CloudWatch log group exists and IAM role has permissions.

---

## ❌ Terraform errors (resource exists)

Resources may already exist.

Use:

```
terraform import
```

or enable lifecycle settings.

---

## ❌ VPC limit exceeded

AWS free accounts have limits.

Use existing VPC or delete unused ones.

---

# 🧰 Useful Commands

### View ECS logs

```
aws logs tail /ecs/strapi --follow
```

### Check running tasks

```
aws ecs list-tasks --cluster strapi-cluster
```

### Terraform locally

```
terraform init
terraform plan
terraform apply
```

---

# 🛠 Future Improvements

### Production Enhancements

✅ Application Load Balancer  
✅ HTTPS (ACM + Route53)  
✅ RDS PostgreSQL database  
✅ Private subnets + NAT Gateway  
✅ Auto scaling  
✅ Secrets Manager for credentials  
✅ CI/CD environment promotion (dev → prod)  
✅ Zero-downtime deployments

---

# 🎯 Learning Outcomes

This project demonstrates:

✔ containerization best practices  
✔ cloud networking fundamentals  
✔ infrastructure as code  
✔ CI/CD automation  
✔ ECS Fargate deployment  
✔ cloud logging & observability  
✔ IAM & security design

---

# 👨‍💻 Author

**Arpit Pandey**

Cloud | DevOps | SRE | Infrastructure Automation
