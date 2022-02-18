resource "aws_instance" "challenge_server" {
  ami = var.amis["us-east-1"]
  provider = aws.us-east-1
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = ["${aws_security_group.ssh.id}", "${aws_security_group.jenkins-sg.id}", "${aws_security_group.sonarqube-sg.id}"]
  tags = {
    Name = "Challenge_server"
  }

  // Preenche arquivo hosts ansible
  provisioner "local-exec" {
    command = "echo ${var.group} '\n' ${aws_instance.challenge_server.public_ip} ${var.ssh} ${var.user} > ${var.host_path}"
  }
}