output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_ceph_dashboard.id}"
  description = "OpenTelemetry Collector Ceph Metrics Dashboard URL"
}
