output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_dashboard.otel_collector_mongodb_summary_dashboard.id}"
  description = "OpenTelemetry Collector MongoDB Metrics Summary Dashboard URL"
}
