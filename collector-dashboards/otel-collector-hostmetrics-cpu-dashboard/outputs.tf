output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_dashboard.otel_collector_hostmetrics_cpu_dashboard.id}"
  description = "OpenTelemetry Collector Host Metrics CPU Dashboard URL"
}
