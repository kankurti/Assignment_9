resource "aws_instance" "flask" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.flask_sg.name]

  user_data = file("userdata-flask.sh")

  tags = { Name = "Flask-Backend" }
}

resource "aws_instance" "express" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.express_sg.name]

  user_data = templatefile("userdata-express.sh", {
    FLASK_PRIVATE_IP = aws_instance.flask.private_ip
  })

  tags = { Name = "Express-Frontend" }
}
