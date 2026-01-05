variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "cluster_name" {
  description = "Danylo EKS cluster"
  type        = string
  default     = "ml-production-cluster"
}