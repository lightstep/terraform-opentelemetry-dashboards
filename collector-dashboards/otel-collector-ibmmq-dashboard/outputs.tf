output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_ibmmq_dashboard.id}"
  description = "OpenTelemetry IBMMQ Integration Dashboard URL"
}
