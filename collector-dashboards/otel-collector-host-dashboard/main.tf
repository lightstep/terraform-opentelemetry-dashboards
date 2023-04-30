terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.76.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_host_dashboard" {

  project_name   = var.lightstep_project
  dashboard_name = "OpenTelemetry / Host"

  chart {
    name = "Disk Read / Write bytes"
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
    name = "Disk Read / Write time"
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
    name = "Disk Usage"
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

  chart {
    name = "Memory used/available"
    rank = "5"
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

  chart {
    name = "Paging Usage used/free"
    rank = "6"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "bar"
      hidden     = false

      metric              = "system.paging.usage"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["state", ]
      }
    }
  }

  chart {
    name = "Paging Operations"
    rank = "7"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "system.paging.operations"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction", ]
      }
    }
  }

  chart {
    name = "Paging Faults"
    rank = "8"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "system.paging.faults"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["type", ]
      }
    }
  }

  chart {
    name = "CPU"
    rank = "9"
    type = "timeseries"

    query {
      query_name          = "a"
      display             = "area"
      hidden              = false

      metric              = "system.cpu.time"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys = ["cpu", "state"]
      }
    }
  }
}
