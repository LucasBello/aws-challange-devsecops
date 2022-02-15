resource "aws_instance" "challenge_server" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name = "aws-geral"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}", "${aws_security_group.jenkins-sg.id}"]
  tags = {
    Name = "Challenge_server"
  }
}