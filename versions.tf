# -----------------------------------------------
# Versions for VPC-ECS
# -----------------------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.70.0"
    }
  }
  required_version = ">= 0.13.0"
}
