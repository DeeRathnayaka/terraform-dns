# Terraform DNS Training

A small Terraform project for managing a DigitalOcean DNS A record.

## Purpose

This project is a training exercise for learning:

- Terraform configuration
- DigitalOcean provider
- Terraform variables
- Input validation
- Terraform state
- Terraform plan and apply
- DNS record lifecycle
- Safe handling of credentials
- Git workflow

## Requirements

For local development and validation:

- Ubuntu / WSL
- Terraform >= 1.15.0

For applying changes to DigitalOcean:

- DigitalOcean account
- DigitalOcean Personal Access Token

A DigitalOcean token is not required for writing, formatting, or validating the Terraform configuration. It is required when Terraform needs to authenticate with DigitalOcean to manage real infrastructure.

## Project Structure

```text
.
├── .gitignore
├── .terraform.lock.hcl
├── main.tf
├── outputs.tf
├── provider.tf
├── terraform.tfvars.example
├── variables.tf
└── versions.tf
