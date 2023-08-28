output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_dashboard.otel_collector_rabbitmqreceiver_dashboard.id}"
  description = "OpenTelemetry RabbitMQ Dashboard URL"
}
