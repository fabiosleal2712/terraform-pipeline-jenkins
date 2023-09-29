resource "aws_key_pair" "keydotnet" {
  key_name   = "keydotnet"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQJIjkW/poiag9oRNXZkxQJ1SGJ4f9a2y60Dsb37xijkYGZEBYG36Knp78ttwKIX9gyu+IOcBok5DGpR4CuYLkM8XxQJcXqACAogOLLPNza5DD3th/anIVp8RrBO27e6c0VdmOdhGYSye1sfDWpwBSIRXneFI52ZHo1KIcIxksYDITeGfUg/CI1/HPFzAdZcld/s/0F6SFRtHnkHHVfI0UvjI9nLQ7wWIoAXVCDkkBAn2Rqp96AkPjvGwHYl7YCe2djGrFbnqMzJfoNtjxZajciW6RYJM/e/ovqPWJ4fq5kk4wWqLbDQyUVSIZebXJQL3jFiIFlbEn1D0gD5gRbaPHvLGV1r2x3v6jFhm0WHyvxI2VQLY22Fbb5DB1NgShNIZnZ0ULt95wnks5efVvQGO3rKDW1SOIQbVqM3a+rbQ61X422xy+fRjDeD3ncg1ICLu+F8XI5wLgGvRVVQt5MfWdXCWDa2Z5VEy/mYOwByU/Fe+IkhJhtSpnFwM+Y6Tcn1U= fabio@fabiodesk1"
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

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              service docker start
              usermod -a -G docker ec2-user
              chkconfig docker on
              curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose
              mkdir -p /home/ec2-user/nginx/_data
              mkdir -p /home/ec2-user/nginx/dornetdocker
              aws s3 sync s3://terraformstate847974/_data /home/ec2-user/nginx/_data
              aws s3 sync s3://terraformstate847974/dornetdocker /home/ec2-user/nginx/dornetdocker
              chown -R ec2-user:ec2-user /home/ec2-user/nginx
              EOF
}
