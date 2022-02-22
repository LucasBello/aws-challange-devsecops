variable "amis" {
    default = {
        "us-east-1" = "ami-04505e74c0741db8d"
    }
}
variable "instance_type" {
    default = "t2.large"
}
variable "key_name"{
    default = "aws-geral"
}

//-----/  Configurações Ansible -------
variable "ssh" {
    default = "ansible_ssh_private_key_file=/home/don/.ssh/aws-geral"
}
variable "group"{
    default = "[challenge_server]"
}
variable "host_path" {
    default = "./ansible/hosts"
}
variable "user"{
    default = "ansible_ssh_user=ubuntu"
}
//-----  Configurações Ansible /-------