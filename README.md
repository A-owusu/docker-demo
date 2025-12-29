# Dockerized Flask App

A minimal, production-ready Flask application packaged in Docker.  
This project demonstrates clean Docker workflows, reproducible builds, and simple containerized development.

---

## 🚀 Features

- Lightweight Python Flask API
- Fully containerized using Docker
- Zero external dependencies
- Runs consistently across environments
- Perfect template for DevOps, CI/CD, and cloud deployment demos

---

## 📦 Project Structure
docker-demo/ │ ├── app/ │   ├── main.py │   └── requirements.txt │ ├── Dockerfile └── README.md


---

## 🐳 Running the App with Docker

### 1. Build the image
```bash
docker build -t docker-demo .