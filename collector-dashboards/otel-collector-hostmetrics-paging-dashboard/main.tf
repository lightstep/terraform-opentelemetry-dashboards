terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_hostmetrics_paging_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Host Metrics / Paging"
  dashboard_description = "Monitor Host Paging metrics."

  chart {
    name = "Usage Used/Free"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric system.paging.usage | latest | group_by ["state"], sum
EOT
    }

  }

  chart {
    name = "Operations"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric system.paging.operations | rate | group_by ["direction"], sum
EOT
    }

  }

  chart {
    name = "Faults"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric system.paging.faults | rate | group_by ["type"], sum
EOT
    }

  }

}
