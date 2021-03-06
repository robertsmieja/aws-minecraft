variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}
variable "availability_zone" {
    default = "us-east-1d"
}
variable "region" {
  default = "us-east-1"
}
variable "allowed_ssh_cidr" {
    default = "0.0.0.0/0"
}
