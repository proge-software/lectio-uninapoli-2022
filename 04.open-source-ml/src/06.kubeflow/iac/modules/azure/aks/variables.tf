variable "environment" {
  type        = string
  description = "Target environment"
}

variable "region" {
  type        = string
  default     = "westeurope"
  description = "Default Azure region"
}

variable "default_tags" {
  type        = map(string)
  default     = {}
  description = "Default Tags associated to the resources"
}

