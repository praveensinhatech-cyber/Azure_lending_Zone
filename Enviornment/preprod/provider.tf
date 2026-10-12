terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.6.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "praveen-pipeline-test-rg"
    storage_account_name = "praveensinhastorage12345"
    container_name       = "praveen-container"     # Jo container pehle se bana hai
    key                  = "dev.terraform.tfstate" # <-- Yeh FILE NAME hai jo automatically banegi
  }
}

provider "azurerm" {
  features {

  }
}
