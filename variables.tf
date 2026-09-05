variable "ec2_instance_type" {
  default = "t3.micro"
  type    = string
}


variable "ec2_default_root_block_device_size" {
  default = 10
  type    = number
}

variable "ec2_ami" {
  default = "ami-01a00762f46d584a1"
  type    = string
}

variable "env" {
  default = "prd"
  type    = string
}