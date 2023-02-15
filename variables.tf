# -----------------------------------------------
# Variables for VPC-ECS
# -----------------------------------------------
variable "project_name" {
  type        = string
  description = "The Project Name."
}

variable "vpc_cidr" {
  type        = string
  description = "The VPC CIDR Block."
}

variable "region" {
  type        = string
  description = "The AWS Region."
}

variable "public_subnets" {
  type        = list(string)
  description = "The list of public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "The list of private subnets"
}

variable "tags" {
  type        = map(string)
  description = "Tags assigned to the created resources"
  default     = {}
}
