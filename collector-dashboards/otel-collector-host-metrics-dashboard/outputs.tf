output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.host_metrics_dashboard.id}"
  description = "Host Metrics Dashboard URL"
}
