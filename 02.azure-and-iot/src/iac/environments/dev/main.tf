terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  region = "westeurope"
  tags = {
    "scope" : "lectio-uninapoli",
    "creator" : "Proge-Software s.r.l",
    "iac" : "Terraform",
  }
  customer    = "proge"
  project     = "lectures"
  scope       = "unina"
  environment = "demo"
}

module "iot" {
  source       = "../../modules/azure/iot"
  location     = local.region
  default_tags = local.tags
  customer     = local.customer
  project      = local.project
  scope        = local.scope
  environment  = local.environment
}
