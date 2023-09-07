variable "environment" {
  type    = string
  default = "dev"
}

variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "intra_subnets" {
  type = list(string)
}


variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}
