output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_couchbasereceiver_dashboard.id}"
  description = "OpenTelemetry Couchbase Integration Dashboard URL"
}
