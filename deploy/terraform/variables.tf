variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "weather-app"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "weather-app"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = [
    "10.0.16.0/20",  # weather-subnet-01 in us-east-1a
    "10.0.32.0/20"   # weather-subnet-02 in us-east-1b
  ]
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = [
    "10.0.48.0/20",  # weather-public-subnet-01 in us-east-1a
    "10.0.64.0/20"   # weather-public-subnet-02 in us-east-1b
  ]
}