variable "aws_region" {
  default = "ap-south-1"
}

variable "key_name" {
  description = "EC2 key pair"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2023 kernel-6.1 AMI"
}
