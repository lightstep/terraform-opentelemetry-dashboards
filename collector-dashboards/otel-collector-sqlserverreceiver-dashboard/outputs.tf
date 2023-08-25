output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_metric_dashboard.otel_collector_sqlserverreceiver_dashboard.id}"
  description = "OpenTelemetry SQL Server Dashboard URL"
}
