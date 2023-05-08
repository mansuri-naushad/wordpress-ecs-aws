# terraform-aws-wordpress-ecs

Terraform module which deploys Wordpress on AWS using ECS Fargate for compute, RDS for database and an application load balancer.

## Example Usage

```hcl
provider "aws" {
  region  = "eu-west-1"
}

module "vpc" {
   source = "terraform-aws-modules/vpc/aws"
   name = "wordpress"
   cidr = "10.0.0.0/16"
   azs = ["eu-west-1a", "eu-west-1b"]
   public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
   private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]
   intra_subnets = ["10.0.4.0/24", "10.0.5.0/24"]
   database_subnets = ["10.0.6.0/24", "10.0.7.0/24"]
   enable_nat_gateway = true
   enable_dns_hostnames = true
}

module "wordpress" {
   source = "github.com/mansuri-naushad/wordpress-ecs-aws"
   ecs_service_subnet_ids = module.vpc.private_subnets
   lb_subnet_ids = module.vpc.public_subnets
   db_subnet_group_subnet_ids = module.vpc.database_subnets
}
```
