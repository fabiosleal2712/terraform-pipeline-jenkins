resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso de qualquer IP (não recomendado para produção)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Todas as portas e protocolos
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso a qualquer destino (não recomendado para produção)
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso de qualquer IP (não recomendado para produção)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Todas as portas e protocolos
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso a qualquer destino (não recomendado para produção)
  }
  ingress {
    from_port   = 444
    to_port     = 444
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso de qualquer IP (não recomendado para produção)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Todas as portas e protocolos
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso a qualquer destino (não recomendado para produção)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso de qualquer IP (não recomendado para produção)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Todas as portas e protocolos
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso a qualquer destino (não recomendado para produção)
  }

  ingress {
    from_port   = 8084
    to_port     = 8084
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso de qualquer IP (não recomendado para produção)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Todas as portas e protocolos
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso a qualquer destino (não recomendado para produção)
  }
}

