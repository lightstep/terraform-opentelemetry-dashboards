output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_sentryobservability_dashboard.id}"
  description = "OpenTelemetry Sentry Observability Dashboard URL"
}
