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

# 1. THE PUBLIC SUBNET (The Lobby)
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # This makes it "Public" - gives every server a public IP
  availability_zone       = "eu-north-1a" # Placing it in a specific Stockholm data center

  tags = {
    Name = "chimera-public-subnet"
  }
}

# 2. THE PUBLIC ROUTE TABLE (The Traffic Sign)
resource "aws_route_table" "public" {
  vpc_id                  = aws_vpc.main.id

  route {
    cidr_block            = "0.0.0.0/0"    # "Everything else" (The Internet)
    gateway_id            = aws_internet_gateway.main.id # Go to the Front Door
  }

  tags = {
      Name = "chimera-public-rt"
    }
}

# 3. THE ASSOCIATION (Connecting the Sign to the Room)
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}