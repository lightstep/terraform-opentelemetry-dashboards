terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.60.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_hostmetrics_disk_dashboard" {

  project_name   = var.lightstep_project
  dashboard_name = "OpenTelemetry / Host Metrics / Disk"

  chart {
    name = "Read / Write bytes"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "system.disk.operations"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["direction", ]
      }

    }

  }

  chart {
    name = "Read / Write time"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "system.disk.operation_time"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["direction", ]
      }

    }

  }

  chart {
    name = "Usage"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "bar"
      hidden     = false

      metric              = "system.filesystem.usage"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = ["state", ]
      }

    }

  }

  chart {
    name = "Total disk"
    rank = "3"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "bar"
      hidden     = false

      metric              = "system.filesystem.usage"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Inode usage"
    rank = "4"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "system.filesystem.inodes.usage"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = ["state", ]
      }

    }

  }

}
