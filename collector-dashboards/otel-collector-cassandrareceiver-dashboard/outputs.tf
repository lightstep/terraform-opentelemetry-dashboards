output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_cassandrareceiver_dashboard.id}"
  description = "OpenTelemetry Cassandra Integration Dashboard URL"
}
