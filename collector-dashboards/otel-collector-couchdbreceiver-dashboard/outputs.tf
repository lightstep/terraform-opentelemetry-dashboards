output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_dashboard.otel_collector_couchdbreceiver_dashboard.id}"
  description = "OpenTelemetry Couchdb Integration Dashboard URL"
}
