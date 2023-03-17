output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_operator_dashboard.id}"
  description = "OpenTelemetry Collector Dashboard URL"
}
