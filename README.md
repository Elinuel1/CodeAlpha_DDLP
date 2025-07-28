## 🔐 Data Leak Prevention (DLP) Demo using AWS & Terraform (aCodeAlpha Internship Project)

This project demonstrates a **secure data submission flow** designed to protect sensitive information (such as usernames and passwords) using modern cloud security best practices. It is built on **AWS** using **Terraform** for Infrastructure as Code (IaC), and supports encrypted data handling, token-based access, and serverless deployment.

### ✨ Features

* **Serverless backend** using AWS Lambda & API Gateway
* **Token-based access control** for secure form submission
* **AES-256 encryption** using AWS KMS
* **WAF integration** to block common threats
* **Terraform-managed infrastructure** (100% reproducible)
* Lightweight **HTML + JS frontend** for secure form submission

### 🔧 Tech Stack

* AWS Lambda (Python)
* Amazon API Gateway (HTTP API)
* AWS KMS (Key Management Service)
* AWS WAF (Web Application Firewall)
* Terraform (IaC)
* HTML, CSS, JavaScript (Frontend)

### 🚀 Usage

1. Deploy infrastructure using Terraform
2. Submit data securely via browser form or cURL
3. Data is encrypted and stored securely
4. Optionally, verify token-based access control

