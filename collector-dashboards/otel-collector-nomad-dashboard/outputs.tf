output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_nomadreceiver_dashboard.id}"
  description = "OpenTelemetry Nomad Integration Dashboard URL"
}
