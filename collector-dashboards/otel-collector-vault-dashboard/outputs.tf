output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_vault_dashboard.id}"
  description = "OpenTelemetry Collector Vault Metrics Dashboard URL"
}
