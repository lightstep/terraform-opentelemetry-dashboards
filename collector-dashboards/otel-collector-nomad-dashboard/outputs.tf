output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_nomad_dashboard.id}"
  description = "OpenTelemetry Collector Nomad Dashboard URL"
}
