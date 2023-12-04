resource "aws_key_pair" "keydotnet" {
  key_name   = "keydotnet"
  public_key = var.SSH_PUBLIC_KEY
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.keydotnet.key_name
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = {
    Name = "EC2-Instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              # Add Docker's official GPG key:
              sudo apt-get update
              sudo apt-get install ca-certificates curl gnupg -y
              sudo install -m 0755 -d /etc/apt/keyrings
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
              sudo chmod a+r /etc/apt/keyrings/docker.gpg
              sudo usermod -aG docker ubuntu
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
              sudo apt-get update
              sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
              sudo apt install docker-compose -y
              EOF
}
