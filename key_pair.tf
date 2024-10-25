resource "aws_key_pair" "tfkp" {
  key_name   = "tfkp"
  public_key = tls_private_key.tls.public_key_openssh
}

resource "tls_private_key" "tls" {
algorithm  = "RSA"
rsa_bits = 4096
} 

resource "local_file" "ssh" {
  filename = "ssh_key"
  content = tls_private_key.tls.private_key_pem
  file_permission = "400"
}