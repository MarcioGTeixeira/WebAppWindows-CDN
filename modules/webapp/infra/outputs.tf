output "app_url" {
  value = azurerm_windows_web_app.appservice.default_hostname
}
output "cdnendpoint_url" {
  value = azurerm_cdn_endpoint.cdnendpoint.origin_host_header

}