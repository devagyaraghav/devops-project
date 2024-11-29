                                                                                      VPC Setup Documentation

Overview:
The repository vpc-setup contains Terraform scripts to configure Virtual Private Clouds (VPCs) and related networking components across multiple AWS regions. 
This setup establishes secure and isolated environments for hosting applications and services, with provisions for public and private subnets, routing, and security group configurations.

Components:
1. VPC Configuration:
Two VPCs are created in different regions (vpc1 and vpc2).
Each VPC includes public and private subnets to segregate workloads.

2. Subnets:
Public and private subnets are defined for each VPC in different availability zones (AZs).
Routing configurations link public subnets to an Internet Gateway (IGW) and private subnets to a NAT Gateway for external access when needed.

3. Internet Gateway (IGW):
Enables internet connectivity for resources within public subnets.

4. NAT Gateway:
Configured for private subnets, allowing outbound internet access without exposing private IP addresses.

5. Route Tables:
Separate route tables for public and private subnets to control traffic flow and ensure proper association with subnets.

6. Security Groups:
Security groups are defined to allow:
HTTP traffic (port 80) from any IP.
SSH access (port 22) from any IP for administrative purposes.
All outbound traffic unrestricted.

7. Providers:
Multi-region setup using different providers for each AWS region (region1 and region2).


Files:
vpc.tf: Contains the main definitions for VPCs, subnets, and gateways.
sg.tf: Sets up security groups for both regions, defining ingress and egress rules.
outputs.tf: Outputs key VPC and subnet details for further use in downstream modules.
Instance.tf and bastion.tf : to create ec2 instances in public and private subnets.
elb.tf : to create load balancers , target groups in both regions.
variables.tf and terraform.tfvars



Usage:
1. Clone the repository: git clone https://github.com/AFZAALAHMEDKHAN/vpc-setup.git
2. Navigate to the project directory: cd vpc-setup
3. Initialize terraform: terraform init
4. terraform plan
5. terraform apply


Prerequesites:

Update the S3 backend info and also configure the machine with your respective aws security credentials.
