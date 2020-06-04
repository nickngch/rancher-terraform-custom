###AWS EC2

variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = ""
}

variable "subnet_cidr" {
  default = ""
}
 
variable "security_group" {
  default = "Nick-testing-sg"
} 

variable "azs" {
  type = list
  default = ["us-east-2a","us-east-2b","us-east-2c"]
}

variable "prefix" {
  default = "Nick-testing"
}

variable "user" {
  default = "ubuntu"
}

variable "ami" {
  default = "ami-0d5d9d301c853a04a"
}

variable "instance_type" {
  default = "t3.large"
}

variable "private_key" {
  default = "NickNg"
}

variable "docker_version" {
  default = "19.03"
}

variable "node_count" {
  default = 3
}

###Rancher API
variable "rancher_url" {
  default = ""
}

variable "access_key" {
  default = ""
}

variable "secret_key" {
  default = ""
}