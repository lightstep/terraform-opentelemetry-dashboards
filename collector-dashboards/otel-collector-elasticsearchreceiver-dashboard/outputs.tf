output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_metric_dashboard.otel_collector_elasticsearchreceiver_dashboard.id}"
  description = "OpenTelemetry Elastic Search Dashboard URL"
}
