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
              echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC19wrMUDmfm+WgT0ZpK49udaOc7W/finJeSFJCIlfASYbX60lg2i/jkzWrX+bnCFla8V8QkzRaL0Ja2kO27siN5yAyoyp8yJ9CiZkaVPGk4lWTw5G71MtSm3uKi9BsdZo2lk2HWvevb4NWNopJum3JP08TZ6rRh/UZozIfyZvS8XZaXo6e2HB2JDJrpcUFaClv3PpdcfbIK/Vx1rOfLdeG3PZrbA29yk76mj5VxI2W3dW64U2h2m6lp0IHv1eNlxItQ+1fZsoJnXr/62PfA/rJ4jAS6/Sx1S4P5v3NiE1FB6cSnrDRywUYxj1h/WMLt1PBvHugy1Mj7/sXzVwgyL5NRDefsosmHQzPyQkitD024pFF/GUVkzznNolkp/0RG6aKmbx26O+PKLIY0AsJUIDrn1W57OKL6i4C/bFl0PDWaND87i7A1cucdYqyPOYHBSTKXwi3ccTT6NGauDDZ2E8iEy9i0RVPRWJEtX4/hh9QC3+04cvazq/uFX5JXHn4fZE= jenkins@6675950ac259" >> /home/ec2-user/.ssh/authorized_keys
              sudo apt update
              sudo apt -y install docker
              sudo service docker start
              sudo usermod -a -G docker ubuntu
              sudo chkconfig docker on
              sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose
              EOF
}
