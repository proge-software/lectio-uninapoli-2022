variable "location" {
  type        = string
  default     = "westeurope"
  description = "Azure Region"
}

variable "default_tags" {
  type = map(string)
  default = {
    "app" : "Unina Lectures",
    "module" : "shared",
    "creator" : "Proge-Software s.r.l",
    "iac" : "Terraform",
  }
}

variable "customer" {
  type    = string
  default = "proge"
}

variable "project" {
  type    = string
  default = "lectures"
}

variable "scope" {
  type    = string
  default = "unina"
}

variable "environment" {
  type    = string
  default = "demo"
}

variable "cosmos_location" {
  type    = string
  default = "ukwest"
}
