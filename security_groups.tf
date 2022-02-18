resource "aws_security_group" "ssh" {
  name = "ssh"
  provider = aws.us-east-1
  description = "Acesso SSH"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
      name = "ssh-acesso"
  }
}

resource "aws_security_group" "jenkins-sg" {
  name = "jenkins-sg"
  description = "Jenkins-sg"
  provider = aws.us-east-1
  ingress {
      description  = "Allow 8080"
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      description  = "Allow 5000"
      from_port = 5000
      to_port = 5000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
      name = "jenkins-sg"
  }
}

resource "aws_security_group" "sonarqube-sg" {
  name = "sonarqube-sg"
  description = "sonarqube-sg"
  provider = aws.us-east-1
  ingress {
      description  = "Allow 9000"
      from_port = 9000
      to_port = 9000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
      name = "sonarqube-sg"
  }
}