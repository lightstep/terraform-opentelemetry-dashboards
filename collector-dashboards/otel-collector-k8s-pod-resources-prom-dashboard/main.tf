terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "k8s_resources_pod_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Kubernetes Resources - Pod"
  dashboard_description = "Monitor K8S Pod Resources with this overview dashboard."

  chart {
    name = "CPU Usage - Seconds"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container_cpu_usage_seconds_total | rate | group_by ["container"], mean
EOT
    }

  }

  chart {
    name = "CPU Usage - Limits/Requests"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_requests | latest | group_by [], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_limits | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "CPU Throttling"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
with
  a = metric container_cpu_cfs_throttled_periods_total | rate | group_by [], sum;
  b = metric container_cpu_cfs_periods_total | rate | group_by [], sum;
join (a / b), a=0, b=0
EOT
    }

  }

  chart {
    name = "Memory Usage (WSS)- Bytes"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container_memory_working_set_bytes | latest | group_by ["container"], sum
EOT
    }

  }

  chart {
    name = "Memory Usage (WSS) - Limits/Requests"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_requests | latest | group_by [], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_limits | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Memory Usage by Container"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric container_memory_working_set_bytes | latest | group_by ["container"], sum
EOT
    }

  }

  chart {
    name = "Receive Bandwidth"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container_network_receive_bytes_total | rate | group_by ["pod"], sum
EOT
    }

  }

  chart {
    name = "Transmit Bandwidth"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container_network_transmit_bytes_total | rate | group_by ["pod"], sum
EOT
    }

  }

  chart {
    name = "Rate of Received Packets"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container_network_receive_packets_total | rate | group_by ["pod"], sum
EOT
    }

  }

  chart {
    name = "Rate of Transmitted Packets"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container_network_transmit_packets_total | rate | group_by ["pod"], sum
EOT
    }

  }

  chart {
    name = "Rate of Received Packets Dropped"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container_network_receive_packets_dropped_total | rate | group_by ["pod"], sum
EOT
    }

  }

  chart {
    name = "Rate of Transmitted Packets Dropped"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container_network_transmit_packets_dropped_total | rate | group_by ["pod"], sum
EOT
    }

  }

  chart {
    name = "IOPS (Pods)"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric container_fs_writes_total | rate | group_by ["pod"], sum;
  b = metric container_fs_reads_total | rate | group_by ["pod"], sum;
join (a + b), a=0, b=0
EOT
    }

  }

  chart {
    name = "ThroughPut (Pods)"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric container_fs_writes_bytes_total | rate | group_by ["pod"], sum;
  b = metric container_fs_reads_bytes_total | rate | group_by ["pod"], sum;
join (a + b), a=0, b=0
EOT
    }

  }

  chart {
    name = "IOPS (Containers)"
    rank = "14"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric container_fs_writes_total | rate | group_by ["container"], sum;
  b = metric container_fs_reads_total | rate | group_by ["container"], sum;
join (a + b), a=0, b=0
EOT
    }

  }

  chart {
    name = "ThroughPut (Containers)"
    rank = "15"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric container_fs_writes_bytes_total | rate | group_by ["container"], sum;
  b = metric container_fs_reads_bytes_total | rate | group_by ["container"], sum;
join (a + b), a=0, b=0
EOT
    }

  }

}
