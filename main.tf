terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  features {}

}

module "webapp" {
  source           = "./modules/webapp/infra"
  rg               = "rg-name-ambiente"
  location         = "Brazilsouth"
  plan             = "service-plan-ambiente"
  os_type          = "Windows"
  sku_name         = "S1"
  appservice       = "appservice-name-ambiente"
  cdnprofile       = "cdnprofile-name-ambiente"
  sku_cdnprofile   = "Standard_Microsoft"
  cdnendpoint_name = "cdnendpoint-name"
  tags = {
    Name     = "terraform-"
    Ambiente = "dev"
  }

}

