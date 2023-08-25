output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_metric_dashboard.otel_collector_riakreceiver_dashboard.id}"
  description = "OpenTelemetry Riak Integration Dashboard URL"
}
