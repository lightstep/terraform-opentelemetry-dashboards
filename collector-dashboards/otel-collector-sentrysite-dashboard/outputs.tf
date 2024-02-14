output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.otel_collector_sentrysite_dashboard.id}"
  description = "OpenTelemetry Sentry Site Dashboard URL"
}
