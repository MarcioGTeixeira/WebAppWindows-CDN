resource "azurerm_resource_group" "rg" {
  name     = var.rg
  location = var.location
  tags     = var.tags
}

resource "azurerm_service_plan" "plan" {
  name                = var.plan
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = var.os_type
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_windows_web_app" "appservice" {
  name                = var.appservice
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.plan.id
  https_only          = true

  site_config {}
  tags = var.tags
}

resource "azurerm_cdn_profile" "cdnprofile" {
  name                = var.cdnprofile
  location            = var.location
  resource_group_name = var.rg
  sku                 = var.sku_cdnprofile
  tags                = var.tags
}

resource "azurerm_cdn_endpoint" "cdnendpoint" {
  name                = var.cdnendpoint_name
  profile_name        = azurerm_cdn_profile.cdnprofile.name
  location            = var.location
  resource_group_name = var.rg
  tags                = var.tags

  origin_host_header = azurerm_windows_web_app.appservice.default_hostname

  origin {
    name      = azurerm_windows_web_app.appservice.name
    host_name = azurerm_windows_web_app.appservice.default_hostname
  }
  delivery_rule {
    name  = "EnforceHTTPS"
    order = "1"
    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }
    url_redirect_action {
      redirect_type = "Found"
      protocol      = "Https"
    }
  }
}  