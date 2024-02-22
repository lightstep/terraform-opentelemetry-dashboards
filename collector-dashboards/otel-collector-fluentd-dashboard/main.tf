terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_fluentdreceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Fluentd Records"
  dashboard_description = "Monitor Fluentd with this metrics overview dashboard."

  chart {
    name = "Incoming records"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric fluentd_input_status_num_records_total | delta | group_by [], sum"
    }

  }

  chart {
    name = "Outgoing records"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric fluentd_output_status_num_records_total | delta | group_by [], sum"
    }

  }

}
