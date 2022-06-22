output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_metric_dashboard.otel_collector_hostmetrics_disk_dashboard.id}"
  description = "OpenTelemetry Collector Host Metrics Disk Dashboard URL"
}
