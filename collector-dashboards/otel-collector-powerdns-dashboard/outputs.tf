output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_powerdnsreceiver_dashboard.id}"
  description = "OpenTelemetry PowerDNS Integration Dashboard URL"
}
