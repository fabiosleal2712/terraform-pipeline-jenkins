variable "SSH_PUBLIC_KEY" {
  description = "The SSH public key"
  type        = string
  default     = ""
}

resource "aws_key_pair" "keydotnet" {
  key_name   = "keydotnet"
  public_key = var.SSH_PUBLIC_KEY
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-08a52ddb321b32a8c"  # Substitua pelo ID da AMI desejada
  instance_type = "t2.micro"
  key_name      = aws_key_pair.keydotnet.key_name
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ssh.id]
}

  tags = {
    Name = "EC2-Instance"
  }

 # Defina o script de inicialização (user_data) para copiar a pasta
  user_data = <<-EOF
    #!/bin/bash
    aws s3 sync _data "s3://terraformstate847974/_data"
    aws s3 sync dornetdocker "s3://terraformstate847974/dornetdocker"
    udo yum update
    sudo yum -y install docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    sudo chkconfig docker on
    sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # Atualize o sistema (opcional)
    yum -y update

    # Instale qualquer software necessário (opcional)
    # yum -y install software

      # Crie uma pasta no diretório /home/ec2-user (ou outro local desejado)
      mkdir -p /home/ec2-user/nginx/_data
      mkdir -p /home/ec2-user/nginx/dornetdocker

      # Copie a pasta local para a instância (substitua /caminho/local/pasta pela pasta local)
      aws s3 cp s3://terraformstate847974/_data/ /home/ec2-user/nginx/_data --recursive 
      aws s3 cp s3://terraformstate847974/_data/ /home/ec2-user/nginx/dornetdocker --recursive 

      # Defina as permissões apropriadas (opcional)
      chown -R ec2-user:ec2-user /home/ec2-user/nginx/_data
      chown -R ec2-user:ec2-user home/ec2-user/nginx/dornetdocker

  EOF
}
