#!/bin/bash
sudo yum update
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
    mkdir -p /home/ec2-user/_data

    # Copie a pasta local para a instância (substitua /caminho/local/pasta pela pasta local)
    aws s3 cp s3://terraformstate847974/_data/ /home/ec2-user/_data --recursive 

    # Defina as permissões apropriadas (opcional)
    chown -R ec2-user:ec2-user /home/ec2-user/_data


