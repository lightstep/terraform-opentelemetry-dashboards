output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_cockroachdb_dashboard.id}"
  description = "OpenTelemetry Collector CockroachDB Metrics Dashboard URL"
}
