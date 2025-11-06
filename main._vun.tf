# main.tf - AWS Infrastructure Configuration

variable "aws_region" {
  description = "Please provide a valid AWS region for the configuration."
  type        = string
}

variable "inbound_cidr_block" {
  description = "Please specify the exact IP ranges (e.g., your public IP address with a /32 suffix, like '192.0.2.1/32') or security groups that should be allowed to access the 'wide_open_sg' security group, restricting '0.0.0.0/0' to only necessary ports and sources."
  type        = string
}

provider "aws" {
  region = var.aws_region
}

# DANGEROUS: This security group allows all incoming traffic from any IP address.
# This exposes any associated EC2 instance to the entire internet, including SSH and database ports.
resource "aws_security_group" "wide_open_sg" {
  name        = "wide-open-sg"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # "-1" signifies all protocols
    cidr_blocks = [var.inbound_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-13"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    Name = "VulnerableSG"
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # An example Amazon Linux 2 AMI
  instance_type = "t2.micro"
  security_groups = [aws_security_group.wide_open_sg.name]

  tags = {
    Name = "ExposedWebServer"
  }
}