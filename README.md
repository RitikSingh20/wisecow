# Wisecow Application Deployment on Kubernetes

## Project Overview

This project demonstrates the containerization and deployment of the Wisecow application on Kubernetes with secure TLS communication and automated CI/CD using GitHub Actions.

---

# Objectives Achieved

- Dockerized the Wisecow application
- Deployed application on Kubernetes
- Exposed application using Kubernetes Service
- Configured Ingress with TLS
- Implemented CI/CD using GitHub Actions
- Added monitoring scripts using Bash

---

# Tech Stack

- Docker
- Kubernetes
- Minikube
- NGINX Ingress Controller
- GitHub Actions
- Bash Scripting
- DockerHub

---

# Project Structure

```text
wisecow/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── k8s/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
├── scripts/
│   ├── app_health_checker.sh
│   └── system_health.sh
├── Dockerfile
├── wisecow.sh
└── README.md
```

---

# Step 1: Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/wisecow.git
cd wisecow
```

---

# Step 2: Dockerization

## Build Docker Image

```bash
docker build -t YOUR_DOCKER_USERNAME/wisecow:latest .
```

## Run Docker Container

```bash
docker run -d -p 4499:4499 YOUR_DOCKER_USERNAME/wisecow:latest
```

## Verify Application

```bash
curl localhost:4499
```

---

# Step 3: Push Docker Image to DockerHub

## Login to DockerHub

```bash
docker login
```

## Push Image

```bash
docker push YOUR_DOCKER_USERNAME/wisecow:latest
```

---

# Step 4: Kubernetes Setup

## Start Minikube

```bash
minikube start
```

## Create Namespace

```bash
kubectl apply -f k8s/namespace.yaml
```

## Deploy Application

```bash
kubectl apply -f k8s/deployment.yaml
```

## Create Service

```bash
kubectl apply -f k8s/service.yaml
```

---

# Step 5: Install Ingress Controller

```bash
minikube addons enable ingress
```

---

# Step 6: TLS Configuration

## Generate TLS Certificate

```bash
openssl req -x509 -nodes -days 365 \
-newkey rsa:2048 \
-keyout tls.key \
-out tls.crt \
-subj "/CN=wisecow.local/O=wisecow"
```

## Create TLS Secret

```bash
kubectl create secret tls wisecow-tls \
--cert=tls.crt \
--key=tls.key \
-n wisecow
```

## Apply Ingress

```bash
kubectl apply -f k8s/ingress.yaml
```

---

# Step 7: Update Hosts File

Edit hosts file:

```bash
sudo nano /etc/hosts
```

Add:

```text
127.0.0.1 wisecow.local
```

---

# Step 8: Access Application

Open browser:

```text
https://wisecow.local
```

---

# Step 9: CI/CD using GitHub Actions

GitHub Actions workflow automatically:

- Builds Docker image
- Pushes image to DockerHub
- Deploys updated image to Kubernetes

Workflow file:

```text
.github/workflows/deploy.yml
```

---

# GitHub Secrets Required

Add the following secrets in GitHub:

| Secret Name | Description |
|---|---|
| DOCKERHUB_USERNAME | DockerHub username |
| DOCKERHUB_TOKEN | DockerHub access token |
| KUBECONFIG | Kubernetes config file |

---

# Monitoring Scripts

## 1. Application Health Checker

Checks application availability using HTTP status code.

Run:

```bash
chmod +x scripts/app_health_checker.sh
./scripts/app_health_checker.sh
```

---

## 2. System Health Monitoring Script

Checks CPU, memory, and disk usage.

Run:

```bash
chmod +x scripts/system_health.sh
./scripts/system_health.sh
```

---

# Verification Commands

## Check Pods

```bash
kubectl get pods -n wisecow
```

## Check Services

```bash
kubectl get svc -n wisecow
```

## Check Ingress

```bash
kubectl get ingress -n wisecow
```

## Check Logs

```bash
kubectl logs deployment/wisecow -n wisecow
```

---

# Outcome

Successfully:

- Containerized the Wisecow application
- Deployed it on Kubernetes
- Enabled secure TLS communication
- Automated CI/CD pipeline
- Implemented monitoring scripts using Bash

---

# Author

Ritik Singh
