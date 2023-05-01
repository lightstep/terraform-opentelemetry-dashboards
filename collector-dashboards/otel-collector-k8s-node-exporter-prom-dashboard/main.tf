terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.76.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "k8s_node_exporter_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Node Exporter"
  dashboard_description = "Monitor your K8S nodes using this overview dashboard with Node Exporter."

  chart {
    name = "Load Average"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_load1 | reduce mean | group_by [], min
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_load5 | reduce mean | group_by [], min
EOT
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_load15 | reduce mean | group_by [], min
EOT
    }

    query {
      query_name   = "d"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_cpu_seconds_total | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "CPU Usage"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric node_cpu_seconds_total | rate | group_by ["cpu"], sum;
  b = metric node_cpu_seconds_total | delta | group_by ["cpu"], count;
join (1 - (a / b)), a=0, b=0
EOT
    }

  }

  chart {
    name = "Memory Usage"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric node_memory_MemAvailable_bytes | reduce mean | group_by [], sum;
  b = metric node_memory_MemTotal_bytes | reduce mean | group_by [], sum;
join (100 - ((a / b) * 100)), a=0, b=0
EOT
    }

  }

  chart {
    name = "Memory Usage"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric node_memory_MemTotal_bytes | reduce mean | group_by [], sum;
  b = metric node_memory_Cached_bytes | reduce mean | group_by [], sum;
  c = metric node_memory_MemFree_bytes | reduce mean | group_by [], sum;
join ((a - c) - b), a=0, b=0, c=0
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_memory_Buffers_bytes | reduce mean | group_by [], sum

EOT
    }

  }

  chart {
    name = "Disk I/O (Bytes)"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_disk_read_bytes_total | rate | group_by [], sum

EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_disk_written_bytes_total | rate | group_by [], sum

EOT
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_disk_io_time_seconds_total | rate | group_by [], sum

EOT
    }

  }

  chart {
    name = "Disk I/O (seconds)"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_disk_io_time_seconds_total | rate | group_by [], sum

EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_disk_discard_time_seconds_total | rate | group_by [], sum

EOT
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_disk_flush_requests_time_seconds_total | rate | group_by [], sum

EOT
    }

  }

  chart {
    name = "Disk Space Usage"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric node_filesystem_size_bytes | latest | group_by ["mountpoint"], max;
  b = metric node_filesystem_avail_bytes | latest | group_by ["mountpoint"], max;
join (1 - (b / a)), a=0, b=0
EOT
    }

  }

  chart {
    name = "Network Received"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_network_receive_bytes_total | rate | group_by ["device"], mean
EOT
    }

  }

  chart {
    name = "Network Transmitted"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_network_transmit_bytes_total | rate | group_by ["device"], mean
EOT
    }

  }

}
