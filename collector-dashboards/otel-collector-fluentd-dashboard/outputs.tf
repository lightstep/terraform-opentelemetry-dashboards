output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_fluentdreceiver_dashboard.id}"
  description = "OpenTelemetry Fluentd Integration Dashboard URL"
}
