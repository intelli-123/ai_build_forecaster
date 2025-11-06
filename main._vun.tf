# main.tf - AWS Infrastructure Configuration

provider "aws" {
  region = "us-east-1"
}

# DANGEROUS: This security group allows all incoming traffic from any IP address.
# This exposes any associated EC2 instance to the entire internet, including SSH and database ports.
resource "aes_ssecurity_group" "wide_open_sg" {
  name        = "wide-open-sg"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # "-1" signifies all protocols
    cidr_blocks = ["0.0.0.0/0"] # This CIDR block means 'from anywhere on the internet'
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

  tagss = {
    Name = "ExposedWebServer"
  }
}



