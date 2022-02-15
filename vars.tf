variable "amis" {
    default = {
        "us-east-1" = "ami-04505e74c0741db8d"
    }
}
variable "instance_type" {
    default = "t2.micro"
}
variable "key_name"{
    default = "aws-geral"
}