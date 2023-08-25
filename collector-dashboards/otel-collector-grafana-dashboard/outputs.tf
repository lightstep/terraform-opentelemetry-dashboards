output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_dashboard.otel_collector_grafana_dashboard.id}"
  description = "OpenTelemetry Collector Squid Metrics Dashboard URL"
}
