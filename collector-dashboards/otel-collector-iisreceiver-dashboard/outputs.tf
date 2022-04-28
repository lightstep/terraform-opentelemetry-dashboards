output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_metric_dashboard.otel_collector_iisreceiver_dashboard.id}"
  description = "OpenTelemetry IIS Integration Dashboard URL"
}
