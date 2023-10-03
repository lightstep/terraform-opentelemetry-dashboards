output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.host_metrics_prom_dashboard.id}"
  description = "Host Metrics Dashboard from Prometheus Node Exporter"
}
