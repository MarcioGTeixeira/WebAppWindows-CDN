output "appurl" {
  value = "https://${module.webapp.app_url}"
}
output "cdnendpointurl" {
  value = "https://${module.webapp.cdnendpoint_url}"

}