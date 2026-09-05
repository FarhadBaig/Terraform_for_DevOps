# Terraform_for_DevOps

A Terraform-based Infrastructure as Code (IaC) project that provisions an AWS EC2 instance end-to-end — from provider configuration and networking to SSH key generation and automated web server setup.

## Overview

This project demonstrates a practical DevOps workflow using Terraform to:

- Configure the AWS provider
- Provision an EC2 instance
- Generate and manage an SSH key pair for secure access
- Automatically install and configure Nginx on the instance at launch
- Expose useful resource attributes (e.g., public IP) as Terraform outputs

It's designed as a hands-on example of combining Terraform with shell scripting for automated server bootstrapping.

## Project Structure

```
Terraform_for_DevOps/
├── provider.tf              # AWS provider configuration
├── terraform.tf              # Terraform settings and required providers/version constraints
├── variables.tf               # Input variable definitions
├── ec2.tf                     # EC2 instance resource definition
├── outputs.tf                  # Output values (e.g., instance public IP)
├── install_nginx.sh            # Shell script to install/configure Nginx on the instance
├── terra_key_ec2                # Private SSH key (generated for EC2 access)
├── terra_key_ec2.pub             # Public SSH key
├── terraform.tfstate              # Terraform state file
├── terraform.tfstate.backup        # Backup of previous state
├── .terraform.lock.hcl              # Provider dependency lock file
├── .gitignore
└── LICENSE.txt
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) (v1.x recommended)
- An AWS account with programmatic access (Access Key ID & Secret Access Key)
- AWS CLI configured (`aws configure`) or credentials set via environment variables
- An existing or generated SSH key pair for EC2 access

## Setup & Usage

1. **Clone the repository**
   ```bash
   git clone https://github.com/FarhadBaig/Terraform_for_DevOps.git
   cd Terraform_for_DevOps
   ```

2. **Configure your AWS credentials**
   ```bash
   aws configure
   ```

3. **Review/update variables**
   Edit `variables.tf` to set values such as region, instance type, or key pair name as needed.

4. **Initialize Terraform**
   ```bash
   terraform init
   ```

5. **Preview the execution plan**
   ```bash
   terraform plan
   ```

6. **Apply the configuration**
   ```bash
   terraform apply
   ```

7. **Access your instance**
   Once provisioning completes, use the public IP from the output along with the generated SSH key:
   ```bash
   ssh -i terra_key_ec2 ec2-user@<public_ip>
   ```

8. **Destroy resources when done**
   ```bash
   terraform destroy
   ```

## What Gets Provisioned

- **EC2 Instance** — a virtual server on AWS, launched with the specified AMI/instance type
- **SSH Key Pair** — used to securely connect to the instance
- **Nginx Web Server** — automatically installed via `install_nginx.sh` as part of instance bootstrap (user data)

## Outputs

After a successful `terraform apply`, key resource details (such as the instance's public IP address) are printed via `outputs.tf`, making it easy to immediately connect to or test the deployed server.

## Security Notes

- Do **not** commit `terra_key_ec2` (private key) or `terraform.tfstate` files to version control — they may contain sensitive data. Ensure these are listed in `.gitignore`.
- Restrict security group rules to only the ports/IPs you need (e.g., SSH on 22, HTTP on 80).

## License

This project is licensed under the terms specified in [LICENSE.txt](./LICENSE.txt).