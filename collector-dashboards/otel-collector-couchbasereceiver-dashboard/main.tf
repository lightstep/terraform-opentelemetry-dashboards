terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_couchbasereceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry couchbasereceiver Integration"

    
}