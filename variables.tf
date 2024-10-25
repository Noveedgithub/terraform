variable "region" {
    default = "eu-west-2"
    sensitive = true
}

variable "ami" {
    default = "ami-0e8d228ad90af673b"
    sensitive = true
}

variable "instance_type" {
    default = "t2.micro"
    sensitive = true
}

variable "instance_name" {
    default = "demo1"
    sensitive = true
}

variable "bucket_name" {
    default = "noveed22102024"
}

# variable "image" {
#     type = string
#     description = "The ID for the machine image (AMI)"

#     validation {
#         condition =


#     }
# }

variable "project_name" {
    default = "lab4"
}