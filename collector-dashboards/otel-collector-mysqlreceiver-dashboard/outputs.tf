output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_mysql_dashboard.id}"
  description = "OpenTelemetry Collector MySQL Metrics Dashboard URL"
}
