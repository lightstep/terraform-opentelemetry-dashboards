output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_dashboard.otel_collector_gunicorn_dashboard.id}"
  description = "OpenTelemetry Collector Gunicorn Metrics Dashboard URL"
}
