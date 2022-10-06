terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.62.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "k8s_resources_pod_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "Kubernetes Resources - Pod (import)"

  chart {
    name = "CPU Usage - Seconds"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "container_cpu_usage_seconds_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "avg"
        keys               = ["container", ]
      }

    }

  }

  chart {
    name = "CPU Usage - Limits/Requests"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "kube_pod_container_resource_requests"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = false

      metric              = "kube_pod_container_resource_limits"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "CPU Throttling"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "area"
      hidden     = true

      metric              = "container_cpu_cfs_throttled_periods_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

    query {
      query_name = "a / b"
      display    = "area"
      hidden     = false

    }

    query {
      query_name = "b"
      display    = "area"
      hidden     = true

      metric              = "container_cpu_cfs_periods_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Memory Usage (WSS)- Bytes"
    rank = "3"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "container_memory_working_set_bytes"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = ["container", ]
      }

    }

  }

  chart {
    name = "Memory Usage (WSS) - Limits/Requests"
    rank = "4"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "kube_pod_container_resource_requests"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = false

      metric              = "kube_pod_container_resource_limits"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Memory Usage by Container"
    rank = "5"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "bar"
      hidden     = false

      metric              = "container_memory_working_set_bytes"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = ["container", ]
      }

    }

  }

  chart {
    name = "Receive Bandwidth"
    rank = "6"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "container_network_receive_bytes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["pod", ]
      }

    }

  }

  chart {
    name = "Transmit Bandwidth"
    rank = "7"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "container_network_transmit_bytes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["pod", ]
      }

    }

  }

  chart {
    name = "Rate of Received Packets"
    rank = "8"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "container_network_receive_packets_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["pod", ]
      }

    }

  }

  chart {
    name = "Rate of Transmitted Packets"
    rank = "9"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "container_network_transmit_packets_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["pod", ]
      }

    }

  }

  chart {
    name = "Rate of Received Packets Dropped"
    rank = "10"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "container_network_receive_packets_dropped_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["pod", ]
      }

    }

  }

  chart {
    name = "Rate of Transmitted Packets Dropped"
    rank = "11"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "container_network_transmit_packets_dropped_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["pod", ]
      }

    }

  }

  chart {
    name = "IOPS (Pods)"
    rank = "12"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = true

      metric              = "container_fs_writes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["pod", ]
      }

    }

    query {
      query_name = "a + b"
      display    = "line"
      hidden     = false

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = true

      metric              = "container_fs_reads_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["pod", ]
      }

    }

  }

  chart {
    name = "ThroughPut (Pods)"
    rank = "13"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = true

      metric              = "container_fs_writes_bytes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["pod", ]
      }

    }

    query {
      query_name = "a + b"
      display    = "line"
      hidden     = false

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = true

      metric              = "container_fs_reads_bytes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["pod", ]
      }

    }

  }

  chart {
    name = "IOPS (Containers)"
    rank = "14"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = true

      metric              = "container_fs_writes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["container", ]
      }

    }

    query {
      query_name = "a + b"
      display    = "line"
      hidden     = false

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = true

      metric              = "container_fs_reads_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["container", ]
      }

    }

  }

  chart {
    name = "ThroughPut (Containers)"
    rank = "15"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = true

      metric              = "container_fs_writes_bytes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["container", ]
      }

    }

    query {
      query_name = "a + b"
      display    = "line"
      hidden     = false

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = true

      metric              = "container_fs_reads_bytes_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["container", ]
      }

    }

  }

}
