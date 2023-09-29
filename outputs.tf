output "vm_ip"{
    value = aws_instance.ec2_instance.public_ip
}

output "SSH_PUBLIC_KEY" {
  value = var.SSH_PUBLIC_KEY
}
