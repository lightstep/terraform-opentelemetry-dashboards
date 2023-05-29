output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_etcd_dashboard.id}"
  description = "OpenTelemetry Collector ETCD Metrics Dashboard URL"
}
