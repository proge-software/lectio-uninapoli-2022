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
}

module "aks" {
  source       = "../../modules/azure/aks"
  region       = local.region
  default_tags = local.tags
  environment  = "unina"
}
