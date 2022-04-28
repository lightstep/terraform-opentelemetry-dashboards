output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_metric_dashboard.otel_collector_couchdbreceiver_dashboard.id}"
  description = "OpenTelemetry Couchdb Integration Dashboard URL"
}
