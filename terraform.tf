provider "aws" {
  region = "eu-north-1"
}

# Create security group
resource "aws_security_group" "multi" {
  name        = "multi-sg"
  description = "sg for multi tier app"
  vpc_id      = "vpc-00819f3da277cf3e3"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch server
resource "aws_instance" "launch_multiserver" {
  ami                    = "ami-01fd6fa49060e89a6"
  instance_type          = "t3.micro"
  key_name               = "terraform"
  vpc_security_group_ids = [aws_security_group.multi.id]

  tags = {
    Name = "multi-service--project"
  }
}
