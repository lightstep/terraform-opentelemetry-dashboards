output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_metric_dashboard.otel_collector_redisreceiver_dashboard.id}"
  description = "OpenTelemetry Collector Redis Integration Dashboard URL"
}
