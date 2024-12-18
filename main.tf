terraform {
  required_version = ">= 1.0.0" # Ensure that the Terraform version is 1.0.0 or higher

  required_providers {
    aws = {
      source  = "hashicorp/aws" # Specify the source of the AWS provider
      version = "~> 4.0"        # Use a version of the AWS provider that is compatible with version
    }
  }
}

provider "aws" {
  region = "ap-southeast-1" # Set the AWS region to US East (N. Virginia)
}

variable "existing_security_group_id" {
  description = "The ID of the existing security group"
  type        = string
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.micro"
  key_name = "lone1connect"
  vpc_security_group_ids = [var.existing_security_group_id]

  tags = {
    Name = "cloud-lone1-test-instance"
  }
}

resource "aws_db_instance" "postgres_db" {
  identifier           = "restored-db"
  allocated_storage    = 10
  engine               = "mysql"
  instance_class = "db.t3.micro"
  engine_version    = "8.4"
  username             = "postgres"
  password             = "postgres"
  db_subnet_group_name = aws_db_subnet_group.private_subnets.name
  vpc_security_group_ids = [aws_security_group.allow_postgres.id]
  skip_final_snapshot  = false
  final_snapshot_identifier = "restored-db-final-snapshot-${replace(timestamp(), ":", "-")}"
  publicly_accessible  = true

  # Restore from the latest snapshot
  #snapshot_identifier = "restored-db-final-snapshot-2024-08-31t10-37-47z"

  lifecycle {
    create_before_destroy = true
  }
}




resource "aws_db_subnet_group" "private_subnets" {
  name       = "main_private_subnets"
  subnet_ids = ["subnet-53f60928", "subnet-5937e014", "subnet-8f6efee6"]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_security_group" "allow_postgres" {
  name        = "allow_postgres"
  description = "Allow inbound postgres traffic"
  vpc_id      = "vpc-7f0e9816"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
