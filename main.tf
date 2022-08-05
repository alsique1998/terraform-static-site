# module "linux_web_app" {
#   source  = "terraform.xom.cloud/ExxonMobil/linux-web-app/azurerm"
#   version = "<ref-version>"
#   # insert required variables here
# }

provider "azurerm" {
  features {}
  client_id: "40b85944-936c-4dba-a6f1-dd574ba04454"
  tenant_id: "d1ee1acd-bc7a-4bc4-a787-938c49a83906"
  subscription_id: "1f401e74-9897-4f2a-9b43-2991c65a3139"
}

# terraform {
#   required_version = ">= 0.15.0"
#   backend "azurerm" {
#     use_azuread_auth = true
#   }
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "=2.67.0"
#     }
#   }
# }

resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-static-site"
  location = "eastus"
}

resource "azurerm_service_plan" "sp" {
  name                = "sp-${var.app-name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "linux-webapp" {
  name                = "linux-webapp-${var.app-name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.sp.location
  service_plan_id     = azurerm_service_plan.sp.id
  zip_deploy_file     = var.zip-site-file

  site_config {}
}