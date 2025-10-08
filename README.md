# infra

Terraform configuration and Helm chart for deploying InvestLab application on Kubernetes.

## What it does

Sets up a complete Kubernetes application environment with PostgreSQL, Redis, and SSL.

## Quick Start

1. Copy the example variables file:
   ```console
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Fill in your values in `terraform.tfvars`

3. Initialize Terraform:
   ```console
   terraform init
   ```

4. Apply the configuration:
   ```console
   terraform apply
   ```

## Requirements

- Terraform installed
- Access to a Kubernetes cluster
- Docker registry credentials
