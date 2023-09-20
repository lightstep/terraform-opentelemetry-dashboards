output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_activedirectorydsreceiver_dashboard.id}"
  description = "OpenTelemetry Active Directory Integration Dashboard URL"
}
