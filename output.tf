output "vm_public_ip" {
    value = aws_instance.vpc_lab.public_ip
}

output "DB_Endpoint" {
    value = substr(aws_db_instance.adhocLab.endpoint, 0, length(aws_db_instance.adhocLab.endpoint) -5)
}