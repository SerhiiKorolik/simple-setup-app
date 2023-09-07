variable "cluster_certificate_authority_data" {
  type        = string
  description = "base64 encoded value to communicate with the cluster"
}

variable "cluster_endpoint" {
  type        = string
  description = "endpoint of Kubernetes API server"
}


variable "cluster_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "app_repositiry_name" {
  type = string
}

variable "chart_repository_name" {
  type = string
}

variable "repository_read_write_access_arns" {
  type = string
}
