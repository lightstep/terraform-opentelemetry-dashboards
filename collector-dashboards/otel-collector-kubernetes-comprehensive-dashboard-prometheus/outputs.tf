output "cluster_dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_kubernetes_comprehensive_dashboard_prometheus.id}"
  description = "OpenTelemetry Collector Kubernetes Comprehensive Dashboard URL"
}
