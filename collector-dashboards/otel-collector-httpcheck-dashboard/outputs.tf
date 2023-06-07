output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_httpcheck_dashboard.id}"
  description = "OpenTelemetry Collector HttpCheck Dashboard URL"
}
