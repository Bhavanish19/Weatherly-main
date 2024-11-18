aws_region    = "us-east-1"
environment   = "production"
project_name  = "weather-app"
cluster_name  = "weather-app"
vpc_cidr      = "10.0.0.0/16"

private_subnet_cidrs = [
  "10.0.16.0/20",  # weather-subnet-01 in us-east-1a
  "10.0.32.0/20"   # weather-subnet-02 in us-east-1b
]

public_subnet_cidrs = [
  "10.0.48.0/20",  # weather-public-subnet-01 in us-east-1a
  "10.0.64.0/20"   # weather-public-subnet-02 in us-east-1b
]