output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_hostmetrics_disk_dashboard.id}"
  description = "Hostmetrics Disk Dashboard URL"
}
