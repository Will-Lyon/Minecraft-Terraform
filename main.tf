terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  shared_credentials_files = ["CHANGE_ME"]
}


resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft_sg"
  description = "Allow inbound traffic on port 25565 and SSH on port 22"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port	= 80
    protocol	= "tcp"
    cidr_blocks = ["192.168.252.133/32", "128.193.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "minecraft-terra" {
  ami     = "ami-0bb84b8ffd87024d8"
  
  instance_type = "t2.small"

  key_name = aws_key_pair.deployer.key_name
  
  associate_public_ip_address = true

  tags = {
    Name = "Minecraft Server"
  }

  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]
}

resource "aws_key_pair" "deployer" {
  key_name 	= "mc_key"
  public_key	= "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiH269FcXD7cjjbqvtvvw5ZTDX5Zu4nEhNGKhZ1fGrJJD1HNpN1ZWIZSFntc+bG+xzymCrpFdIpZFCy/5fKjdb2jDK4uBvsllMiT4b3rQ5Emni7MzGkHt/hPoKnWdmXz19GA3yKsXOEwUq/SuSSGqlfa+trcSZFGwnuWV5tL6x/Tj/SkZmY0BCDhK5VOwzW5Ucm3KH7IbHizgmiiaDgfYkn6mRuVpjq0rvY1l4/0iXXG8NNCVMNYCn5qQvq0s23GpsNdSEX3nVRHtFBZ3q3Gf2Rv7QTR/OUMw31+rgKeKlb+DK96ymLBrwhtU6KcUstsUcZqmM1WseBH+hXxVGIh8N"
}
