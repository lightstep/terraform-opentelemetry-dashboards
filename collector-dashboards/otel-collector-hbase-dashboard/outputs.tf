output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_hbase_dashboard.id}"
  description = "OpenTelemetry Collector HBase Dashboard URL"
}
