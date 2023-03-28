output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.oetl_collector_hostmetrics_disk.id}"
  description = "Hostmetrics Disk Dashboard URL"
}
