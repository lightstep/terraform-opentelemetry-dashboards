terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.88.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_hostmetrics_memory_dashboard" {

  project_name   = var.lightstep_project
  dashboard_name = "Host Metrics / Memory"


  chart {
    name = "Usage used/available"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "bar"
      hidden     = false

      metric              = "system.memory.usage"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["state", ]
      }
    }
  }
}
