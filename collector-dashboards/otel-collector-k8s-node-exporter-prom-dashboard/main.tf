terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.6"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "k8s_node_exporter_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "Node Exporter (import)"

  chart {
    name = "Load Average"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "node_load1"
      timeseries_operator = "avg"


      group_by {
        aggregation_method = "min"
        keys               = []
      }

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = false

      metric              = "node_load5"
      timeseries_operator = "avg"


      group_by {
        aggregation_method = "min"
        keys               = []
      }

    }

    query {
      query_name = "c"
      display    = "line"
      hidden     = false

      metric              = "node_load15"
      timeseries_operator = "avg"


      group_by {
        aggregation_method = "min"
        keys               = []
      }

    }

    query {
      query_name = "d"
      display    = "line"
      hidden     = false

      metric              = "node_cpu_seconds_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "CPU Usage"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "1 - a / b"
      display    = "line"
      hidden     = false

    }

    query {
      query_name = "a"
      display    = "line"
      hidden     = true

      metric              = "node_cpu_seconds_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["cpu", ]
      }

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = true

      metric              = "node_cpu_seconds_total"
      timeseries_operator = "delta"


      group_by {
        aggregation_method = "count"
        keys               = ["cpu", ]
      }

    }

  }

  // NOTE: The Grafana Dashboard in kube-prometheus-stack uses a big_number
  // type of display.
  chart {
    name = "Memory Usage"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "100 - a / b * 100"
      display    = "line"
      hidden     = false

    }

    query {
      query_name = "a"
      display    = "line"
      hidden     = true

      metric              = "node_memory_MemAvailable_bytes"
      timeseries_operator = "avg"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = true

      metric              = "node_memory_MemTotal_bytes"
      timeseries_operator = "avg"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Memory Usage"
    rank = "3"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = true

      metric              = "node_memory_MemTotal_bytes"
      timeseries_operator = "avg"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

    query {
      query_name = "a - f - e"
      display    = "line"
      hidden     = false

    }

    query {
      query_name = "d"
      display    = "line"
      hidden     = false

      metric              = "node_memory_Buffers_bytes"
      timeseries_operator = "avg"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

    query {
      query_name = "e"
      display    = "line"
      hidden     = false

      metric              = "node_memory_Cached_bytes"
      timeseries_operator = "avg"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

    query {
      query_name = "f"
      display    = "line"
      hidden     = false

      metric              = "node_memory_MemFree_bytes"
      timeseries_operator = "avg"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Disk I/O (Bytes)"
    rank = "4"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "node_disk_read_bytes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = false

      metric              = "node_disk_written_bytes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

    query {
      query_name = "c"
      display    = "line"
      hidden     = true

      metric              = "node_disk_io_time_seconds_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Disk I/O (seconds)"
    rank = "5"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "node_disk_io_time_seconds_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = false

      metric              = "node_disk_discard_time_seconds_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

    query {
      query_name = "c"
      display    = "line"
      hidden     = false

      metric              = "node_disk_flush_requests_time_seconds_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Disk Space Usage"
    rank = "6"
    type = "timeseries"

    query {
      query_name = "1 - b / a"
      display    = "line"
      hidden     = false

    }

    query {
      query_name = "a"
      display    = "line"
      hidden     = true

      metric              = "node_filesystem_size_bytes"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "max"
        keys               = ["mountpoint", ]
      }

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = true

      metric              = "node_filesystem_avail_bytes"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "max"
        keys               = ["mountpoint", ]
      }

    }

  }

  chart {
    name = "Network Received"
    rank = "7"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "node_network_receive_bytes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "avg"
        keys               = ["device", ]
      }

    }

  }

  chart {
    name = "Network Transmitted"
    rank = "8"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "node_network_transmit_bytes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "avg"
        keys               = ["device", ]
      }

    }

  }

}
