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
    name = "idle"
    rank = "0"
    type = "timeseries"

    query {
      query_name          = "a"
      display             = "area"
      hidden              = false

      metric              = "system.cpu.time"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys = ["cpu",]
      }
    }
  }

  chart {
    name = "interrupt"
    rank = "1"
    type = "timeseries"

    query {
      query_name          = "a"
      display             = "area"
      hidden              = false

      metric              = "system.cpu.time"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys = ["cpu",]
      }
    }
  }

  chart {
    name = "nice"
    rank = "2"
    type = "timeseries"

    query {
      query_name          = "a"
      display             = "area"
      hidden              = false

      metric              = "system.cpu.time"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys = ["cpu",]
      }
    }
  }

  chart {
    name = "softirq"
    rank = "3"
    type = "timeseries"

    query {
      query_name          = "a"
      display             = "area"
      hidden              = false

      metric              = "system.cpu.time"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys = ["cpu",]
      }
    }
  }

  chart {
    name = "steal"
    rank = "4"
    type = "timeseries"

    query {
      query_name          = "a"
      display             = "area"
      hidden              = false

      metric              = "system.cpu.time"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys = ["cpu",]
      }
    }
  }

  chart {
    name = "system"
    rank = "5"
    type = "timeseries"

    query {
      query_name          = "a"
      display             = "area"
      hidden              = false

      metric              = "system.cpu.time"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys = ["cpu",]
      }
    }
  }

  chart {
    name = "user"
    rank = "6"
    type = "timeseries"

    query {
      query_name          = "a"
      display             = "area"
      hidden              = false

      metric              = "system.cpu.time"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys = ["cpu",]
      }
    }
  }

  chart {
    name = "wait"
    rank = "7"
    type = "timeseries"

    query {
      query_name          = "a"
      display             = "area"
      hidden              = false

      metric              = "system.cpu.time"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys = ["cpu",]
      }
    }
  }

  #chart {
  #  name = "Total cores"
  #  rank = "8"
  #  type = "timeseries"

  #  query {
  #    query_name          = "a"
  #    display             = "big_number"
  #    hidden              = false

  #    metric              = "system.cpu.time"
  #    timeseries_operator = "delta"


  #    group_by {
  #      aggregation_method = "count_non_zero"
  #      keys = []
  #    }
  #  }
  #}
}




