output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_teamcity_dashboard.id}"
  description = "OpenTelemetry Team City Dashboard URL"
}
