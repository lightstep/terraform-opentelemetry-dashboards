output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_sentryhost_dashboard.id}"
  description = "OpenTelemetry Sentry Host Dashboard URL"
}
