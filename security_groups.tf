resource "aws_security_group" "ssh" {
  name = "ssh"
  description = "Acesso SSH"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
      name = "ssh-acesso"
  }
}

resource "aws_security_group" "jenkins-sg" {
  name = "jenkins-sg"
  description = "Jenkins-sg"
  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
      name = "jenkins-sg"
  }
}