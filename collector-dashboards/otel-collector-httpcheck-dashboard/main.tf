terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.86.1"
    }
  }
  required_version = ">= v1.0.11"
}


resource "lightstep_dashboard" "otel_collector_httpcheck_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "HttpCheck"
  dashboard_description = "Monitor the HTTPCheck of your OpenTelemetry Collector instances"

  chart {
    name = "HTTPCheck Duration"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric httpcheck.duration | rate | group_by [], sum"
    }

  }

  chart {
    name = "HTTPCheck Status Code"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric httpcheck.status | rate | group_by [], sum"
    }

  }

}
