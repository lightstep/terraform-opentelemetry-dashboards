output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_wildfly_dashboard.id}"
  description = "OpenTelemetry Collector JBoss Wildfly Metrics Dashboard URL"
}
