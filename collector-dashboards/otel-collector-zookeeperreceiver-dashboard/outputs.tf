output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_zookeeperreceiver_dashboard.id}"
  description = "OpenTelemetry Zookeeper Integration Dashboard URL"
}
