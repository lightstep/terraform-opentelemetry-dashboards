output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_scylladb_dashboard.id}"
  description = "OpenTelemetry ScyllaDB Dashboard URL"
}
