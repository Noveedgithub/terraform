provider "aws" {
  profile = "default"
  region = var.region
}

resource "aws_instance" "database" {
   ami           = var.ami
   instance_type = var.instance_type
   key_name = "tfkp"
   vpc_security_group_ids = [aws_security_group.tfsg.id, aws_security_group.ec2_to_rds.id]
   depends_on = [aws_key_pair.tfkp]
   user_data =<<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install mysql-client -y
    pwd
    EOF
  user_data_replace_on_change = true
}

resource  "aws_security_group" "rds_to_ec2" {
  name = "rds_to_ec2"
  description = "rds_to_ec2"
}

resource  "aws_security_group" "ec2_to_rds" {
  name = "ec2_to_rds"
  description = "ec2_to_rds"
}

resource "aws_security_group_rule" "ec2_rds" {
  security_group_id = aws_security_group.ec2_to_rds.id
  type = "egress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
    source_security_group_id = aws_security_group.rds_to_ec2.id
}

resource "aws_security_group_rule" "rds_ec2" {
  security_group_id = aws_security_group.rds_to_ec2.id
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
    source_security_group_id = aws_security_group.ec2_to_rds.id
}

resource "aws_db_subnet_group" "database" {
  name       = "database"
  subnet_ids = ["subnet-0cfa0840a3977d1c9", "subnet-0600bf151649b3ca8", "subnet-0d2469f2ab6953abe"]
}

resource "aws_db_instance" "adhocLab" {
  allocated_storage    = 10
  db_name              = "adhocLab"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "noveed"
  password             = "Password01."
  parameter_group_name = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.rds_to_ec2.id]
  skip_final_snapshot  = true
}