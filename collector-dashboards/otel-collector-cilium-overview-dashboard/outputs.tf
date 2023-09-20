output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_cilium_overview_dashboard.id}"
  description = "OpenTelemetry Collector Cilium Metrics Overview Dashboard URL"
}
