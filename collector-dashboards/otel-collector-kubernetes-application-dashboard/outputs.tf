output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.cloud_observability_project}/dashboard/${lightstep_dashboard.otel_collector_kubernetes_application.id}"
  description = "OpenTelemetry Collector Kubernetes Application Dashboard URL"
}