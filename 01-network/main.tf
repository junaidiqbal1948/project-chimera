# 1. THE VPC (The Perimeter)
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16" # Provides 65,536 private IP addresses
  enable_dns_support   = true          # Essential for internal service communication
  enable_dns_hostnames = true          # Essential for Kubernetes later

  tags = {
    Name        = "chimera-vpc"
    Project     = "Project-Chimera"
    Environment = "Dev"
    Owner       = "The-Force-Multiplier"
  }
}

# 2. THE INTERNET GATEWAY (The Front Door)
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id # Links this gateway to the VPC we just created

  tags = {
    Name = "chimera-igw"
  }
}
