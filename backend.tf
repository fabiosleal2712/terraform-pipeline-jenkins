terraform {
  backend "s3" {
    bucket         = "terraformstate847974"
    key            = "dotnet583973/terraform.tfstate"
    region         = "us-east-1"  # Substitua pela região desejada
    encrypt        = true
    
  }
}