output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_dashboard.otel_collector_haproxy_dashboard.id}"
  description = "OpenTelemetry Collector HAProxy Metrics Dashboard URL"
}
