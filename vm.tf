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

}
