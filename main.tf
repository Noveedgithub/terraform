# provider "aws" {
#   profile = "default"
#   region = var.region
# }

# resource "aws_s3_bucket" "demo1-s3" {
#   bucket = var.bucket_name

# tags = {
# Name = var.project_name
#   }
# }

# resource "aws_key_pair" "tfkp" {
#   key_name   = "tfkp"
#   public_key = tls_private_key.tls.public_key_openssh
# }

# resource "tls_private_key" "tls" {
# algorithm  = "RSA"
# rsa_bits = 4096
# } 

# resource "local_file" "ssh" {
#   filename = "ssh_key"
#   content = tls_private_key.tls.private_key_pem
#   file_permission = "400"
# }

# resource "aws_instance" "lab4" {
#    ami           = var.ami
#    instance_type = var.instance_type
#    key_name = "tfkp"
#    vpc_security_group_ids = [aws_security_group.tfsg.id]
#    depends_on = [aws_key_pair.tfkp]
# }