provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = "172.16.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "main"
  }
}

# Add subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.16.1.0/24"
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "main-subnet"
  }
}

# Add internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "main-igw"
  }
}

#Create security group with firewall rules
resource "aws_security_group" "jenkins-sg-2022" {
  name        = var.security_group
  description = "security group for Ec2 instance"
  vpc_id      = aws_vpc.main.id  # ← Added this line
  
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # outbound from jenkins server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = var.security_group
  }
}

resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  key_name      = var.key_name
  instance_type = var.instance_type
  subnet_id     = aws_subnet.main.id  # ← Added this line
  vpc_security_group_ids = [aws_security_group.jenkins-sg-2022.id]
  
  tags = {
    Name = var.tag_name
  }
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  domain   = "vpc"  # ← Updated syntax
  instance = aws_instance.myFirstInstance.id
  
  tags = {
    Name = "my_elastic_ip"
  }
}
