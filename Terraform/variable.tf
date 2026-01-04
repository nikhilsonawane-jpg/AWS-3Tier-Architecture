variable "aws_region" {
  default = "ap-south-1"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "availability_zones" {
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "ami" {
  default = "ami-00ca570c1b6d79f36"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "alert_email" {
  type = string
}

data "aws_secretsmanager_secret_version" "db_secret" {
  secret_id = aws_secretsmanager_secret.db_secret.id
}
