output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_kubernetes_application_dashboard.id}"
  description = "OpenTelemetry Collector Kubernetes Application Dashboard URL"
}