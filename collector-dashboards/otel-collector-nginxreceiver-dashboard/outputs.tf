output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_dashboard.otel_collector_nginxreceiver_dashboard.id}"
  description = "OpenTelemetry Nginx Dashboard URL"
}
