terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "host_metrics_prom_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Host Metrics (Prometheus)"
  dashboard_description = "Monitor hosts such as [Kubernetes nodes](https://kubernetes.io/docs/concepts/architecture/nodes/) with metrics from the Prometheus [**Node Exporter**](https://prometheus.io/docs/guides/node-exporter/).\n\nThe queries for these charts expect prometheus metric names. For a native OpenTelemetry solution, collect metrics with the OpenTelemetry [hostmetricsreceiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/hostmetricsreceiver) and use the prebuilt Host Metrics dashboard."

  chart {
    name = "Load Average"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_load1 | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | reduce mean | group_by [], min
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_load5 | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | reduce mean | group_by [], min
EOT
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_load15 | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | reduce mean | group_by [], min
EOT
    }

    query {
      query_name   = "d"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_cpu_seconds_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by [], sum
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
  a = metric node_cpu_seconds_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by ["cpu"], sum;
  b = metric node_cpu_seconds_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | delta | group_by ["cpu"], count;
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
  a = metric node_memory_MemAvailable_bytes | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | reduce mean | group_by [], sum;
  b = metric node_memory_MemTotal_bytes | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | reduce mean | group_by [], sum;
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
  a = metric node_memory_MemTotal_bytes | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | reduce mean | group_by [], sum;
  b = metric node_memory_Cached_bytes | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | reduce mean | group_by [], sum;
  c = metric node_memory_MemFree_bytes | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | reduce mean | group_by [], sum;
join ((a - c) - b), a=0, b=0, c=0
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_memory_Buffers_bytes | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | reduce mean | group_by [], sum

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
metric node_disk_read_bytes_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by [], sum

EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_disk_written_bytes_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by [], sum

EOT
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_disk_io_time_seconds_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by [], sum

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
metric node_disk_io_time_seconds_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by [], sum

EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_disk_discard_time_seconds_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by [], sum

EOT
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric node_disk_flush_requests_time_seconds_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by [], sum

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
  a = metric node_filesystem_size_bytes | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | latest | group_by ["mountpoint"], max;
  b = metric node_filesystem_avail_bytes | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | latest | group_by ["mountpoint"], max;
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
metric node_network_receive_bytes_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by ["device"], mean
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
metric node_network_transmit_bytes_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by ["device"], mean
EOT
    }

  }

  template_variable {
    name                     = "net_host_name"
    default_values           = []
    suggestion_attribute_key = "net.host.name"
  }
  template_variable {
    name                     = "service_name"
    default_values           = []
    suggestion_attribute_key = "service.name"
  }

  label {
    key   = ""
    value = "prometheus"
  }
}
