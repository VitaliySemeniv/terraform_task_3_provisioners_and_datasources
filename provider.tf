terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7c43b80f-286d-4af9-9c5f-c34a65078107"
  tenant_id       = "dc2e9dea-18de-47c9-a622-68c6067d0c69"
}
