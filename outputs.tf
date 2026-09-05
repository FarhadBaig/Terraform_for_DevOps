#outputs for single instance 

#output "ec2_public_ip" {
# value = aws_instance.my_instance[*].public_ip
#}

#output "ec2_public_dns" {
# value = aws_instance.my_instance[*].public_dns
#}

#output "ec2_private_ip" {
# value = aws_instance.my_instance[*].private_ip
#}


# Outputs for multiple instances using for_each
output "ec2_public_ips" {
  value = [
    for instance in aws_instance.my_instance : instance.public_ip
  ]
}

output "ec2_public_dns" {
  value = [
    for instance in aws_instance.my_instance : instance.public_dns
  ]
}

output "ec2_private_ips" {
  value = [
    for instance in aws_instance.my_instance : instance.private_ip
  ]
}

