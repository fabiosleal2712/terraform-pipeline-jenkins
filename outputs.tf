output "vm_ip"{
    value = aws_instance.ec2_instance.public_ip
}

variable "SSH_PUBLIC_KEY" {
  description = "The SSH public key"
  type        = string
}
