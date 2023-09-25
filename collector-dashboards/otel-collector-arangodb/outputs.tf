output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_arangodb_dashboard.id}"
  description = "OpenTelemetry ArangoDB Integration Dashboard URL"
}
