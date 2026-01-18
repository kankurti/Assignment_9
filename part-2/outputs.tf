output "express_url" {
  value = "http://${aws_instance.express.public_ip}:3000"
}
