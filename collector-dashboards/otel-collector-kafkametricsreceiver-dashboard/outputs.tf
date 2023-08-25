output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_metric_dashboard.otel_collector_kafkametricsreceiver_dashboard.id}"
  description = "OpenTelemetry Kafka Dashboard URL"
}
