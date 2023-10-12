resource "aws_key_pair" "keydotnet" {
  key_name   = "keydotnet"
  public_key = var.SSH_PUBLIC_KEY
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-08a52ddb321b32a8c"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.keydotnet.key_name
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = {
    Name = "EC2-Instance"
  }

#  user_data = <<-EOF
#              #!/bin/bash
#              yum update -y
#              yum install -y docker
#              service docker start
#              usermod -a -G docker ec2-user
#              chkconfig docker on
#              curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
#              chmod +x /usr/local/bin/docker-compose
#              mkdir -p /home/ec2-user/nginx/_data
#              mkdir -p /home/ec2-user/nginx/dornetdocker
#              aws s3 sync s3://terraformstate847974/_data /home/ec2-user/nginx/_data
#              aws s3 sync s3://terraformstate847974/dornetdocker /home/ec2-user/nginx/dornetdocker
#              chown -R ec2-user:ec2-user /home/ec2-user/nginx
#              EOF
}
