variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Name of the AWS Key Pair"
  type        = string
  default     = "terraform-key"  # must match your AWS key pair
}
