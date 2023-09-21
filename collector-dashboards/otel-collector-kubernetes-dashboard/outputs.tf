output "cluster_dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.k8s_compute_resources_cluster.id}"
  description = "OpenTelemetry Collector Kubernetes Cluster Dashboard URL"
}


output "workload_dashboard_url" {
  value       = [for wl in lightstep_dashboard.k8s_compute_resources_workload : "https://app.lightstep.com/${var.lightstep_project}/dashboard/${wl.id}"]
  description = "OpenTelemetry Collector Kubernetes Workload Dashboard URL"
}
