output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_riakreceiver_dashboard.id}"
  description = "OpenTelemetry Riak Integration Dashboard URL"
}
