# Creating A Highly Available Two-Tier Architecture With Terraform (Security Best Practices)

## Objective

This project demonstrates how to create a highly available two-tier AWS architecture using Terraform, adhering to security best practices. The architecture includes:

1. **Custom VPC**:
   - 2 Public Subnets for the Web Server Tier.
   - 2 Private Subnets for the RDS Tier.
   - Appropriate Route Tables.

2. **Web Server Tier**:
   - EC2 Instances with Apache web servers in public subnets.

3. **Database Tier**:
   - An RDS MySQL instance deployed in private subnets.

4. **Security Groups**:
   - Properly configured to allow only necessary traffic between resources.

## Two-Tier Architecture Overview

A two-tier architecture splits an application into two layers:
- **Web Server Tier**: Handles the user interface and application logic, deployed in public subnets for internet accessibility.
- **Database Tier**: Manages data storage, deployed in private subnets for enhanced security.

Using Terraform simplifies the management and deployment of such architectures, ensuring scalability and availability.

---

## Prerequisites

- AWS Free-Tier Account.
- IDE with Terraform capabilities (e.g., Cloud9).
- Basic knowledge of Shell Scripting.

---

## Project Structure

This repository contains the following Terraform configuration files:

- `vpc.tf`: Defines the VPC, subnets, route tables, and gateways.
- `ec2.tf`: Configures EC2 instances for the web server tier.
- `rds.tf`: Sets up the RDS MySQL instance for the database tier.
- `variables.tf`: Contains variable definitions for reusability and customization.

---

## File Details

### `vpc.tf`

Creates a custom VPC with the following:
- **Public Subnets** for web servers.
- **Private Subnets** for the RDS instance.
- **Route Tables** for public and private traffic management.
- **Internet Gateway** for public access.
- **NAT Gateway** for private subnet internet access.

### `ec2.tf`

Defines the EC2 instances for the Web Server Tier:
- Deploys one EC2 instance in each public subnet.
- Installs and configures Apache.
- Includes a Security Group allowing HTTP (port 80) traffic.

### `rds.tf`

Configures a highly available RDS MySQL instance:
- Deployed in private subnets.
- Includes a Security Group allowing traffic only from the Web Server Tier.

### `variables.tf`

Defines customizable variables such as AWS access keys and region.

---

## Deployment Instructions

### Step 1: Clone the Repository
```bash
git clone https://github.com/AbdoElboshy/Two_Tier_Archicture.git
cd Two_Tier_Archicture
```

### Step 2: Configure Variables
Update the `variables.tf` file with your AWS credentials and region.

### Step 3: Initialize Terraform
Run the following command to initialize Terraform:
```bash
terraform init
```

### Step 4: Plan the Infrastructure
Preview the changes that Terraform will apply:
```bash
terraform plan
```

### Step 5: Apply the Configuration
Deploy the infrastructure:
```bash
terraform apply
```

---

## Features

- **High Availability**: Multi-AZ deployment ensures minimal downtime.
- **Scalability**: Easily add more resources as needed.
- **Security Best Practices**: Isolated database tier and carefully configured Security Groups.

---

## Contributing

Feel free to contribute to this project by following these steps:
1. Fork the repository.
2. Create a new branch (`feature-name`).
3. Make your changes and commit them.
4. Push your branch and open a PR.

---

## License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute it.

---

## Author

Developed by [AbdoElboshy](https://github.com/AbdoElboshy). For questions or feedback, feel free to contact me.
