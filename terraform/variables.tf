variable "region" {
  default = "us-east-1"
}

variable "instance_type_app" {
  default = "t2.micro"
}

variable "instance_type_db" {
  default = "t3.micro"
}

variable "db_name" {
  default = "reportes_db"
}

variable "db_user" {
  default = "reportes_user"
}

variable "db_password" {
  default = "Admin1234!"
}

variable "app_port" {
  default = 8080
}
