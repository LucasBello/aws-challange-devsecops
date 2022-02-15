terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "challenge_server" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name = "aws-geral"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
  tags = {
    Name = "Challenge_server"
  }
}