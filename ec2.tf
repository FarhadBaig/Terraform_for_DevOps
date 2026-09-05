# key pair
resource "aws_key_pair" "my_key" {
  key_name   = "terra_key_ec2"
  public_key = file("terra_key_ec2.pub")
}

# VPC & security

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id #interpolation 

#inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH open"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow http open"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow notes-app open"
  }

  #outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All access open outbound"
  }

  tags = {
    Name = "automate-sg"
  }
}



# ec2 instance
resource "aws_instance" "my_instance" {
  for_each = tomap({
    Freddy_automate_micro  = "t3.micro"
    Freddy_automate_medium = "t3.micro"
  }) #meta arguments

  depends_on      = [aws_security_group.my_security_group, aws_key_pair.my_key]
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = each.value
  ami             = var.ec2_ami              # Unbuntu 22.04 LTS (HVM), SSD Volume Type
  user_data       = file("install_nginx.sh") # script to install nginx

  root_block_device {
    volume_size = var.env == "prd" ? 20 : var.ec2_default_root_block_device_size
    volume_type = "gp3"
  }

  tags = {
    Name = "${each.key}"
  }
}