terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.89.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "host_metrics_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Host Metrics"
  dashboard_description = "Monitor hosts such as [Kubernetes nodes](https://kubernetes.io/docs/concepts/architecture/nodes/) with metrics from the OpenTelemetry [**hostmetricsreceiver**](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/hostmetricsreceiver)"

  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"

    text_panel {
      name   = "About this dashboard"
      x_pos  = 0
      y_pos  = 0
      width  = 48
      height = 10
      text   = "This dashboard monitors resource usage across host systems, including [Kubernetes nodes](https://kubernetes.io/docs/concepts/architecture/nodes/). The charts are powered by metrics from the OpenTelemetry [**hostmetricsreceiver**](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/hostmetricsreceiver) with the following scrapers and optional metrics enabled:\n* [cpu](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md) (with [`system.cpu.utilization`](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/cpuscraper/documentation.md#systemcpuutilization) enabled)\n* [disk](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/diskscraper/documentation.md)\n* [filesystem](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/filesystemscraper/documentation.md#hostmetricsreceiverfilesystem) (with [`system.filesystem.utilization`](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/filesystemscraper/documentation.md#systemfilesystemutilization) enabled)\n* [load](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/loadscraper/documentation.md)\n* [memory](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/memoryscraper/documentation.md) (with [`system.memory.utilization`](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/memoryscraper/documentation.md#systemmemoryutilization) enabled)\n* [network](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/internal/scraper/networkscraper/documentation.md)\n\nThese metrics are equivalent to the [Prometheus Node Exporter](https://prometheus.io/docs/guides/node-exporter/)."
    }

    chart {
      name        = "Load Average"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 10
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric system.cpu.load_average.1m | filter ((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) | reduce mean | group_by [], max"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric system.cpu.load_average.5m | filter ((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) | reduce mean | group_by [], max"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric system.cpu.load_average.15m | filter ((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) | reduce mean | group_by [], max"
      }
    }
    chart {
      name        = "CPU Usage"
      description = ""
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 10
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric system.cpu.utilization | filter (((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) && (\"state\" != \"idle\")) | reduce mean | group_by [], mean | point ((value *100.00000))"
      }
    }
    chart {
      name        = "Average Memory Usage"
      description = ""
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 10
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric system.memory.utilization | filter ((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) | reduce mean | group_by [], mean | point (value *100.00000)"
      }
    }
    chart {
      name        = "Memory Usage"
      description = ""
      type        = "timeseries"
      rank        = 3
      x_pos       = 0
      y_pos       = 18
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric system.memory.usage | filter ((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) | latest | group_by [\"state\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric system.memory.usage | filter ((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) | latest | group_by [], sum"
      }
    }
    chart {
      name        = "Disk I/O (Bytes)"
      description = ""
      type        = "timeseries"
      rank        = 4
      x_pos       = 16
      y_pos       = 18
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric system.disk.io | filter (((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) && (\"direction\" == \"read\")) | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric system.disk.io | filter (((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) && (\"direction\" == \"write\")) | rate | group_by [], sum"
      }
    }
    chart {
      name        = "Disk I/O (Time)"
      description = ""
      type        = "timeseries"
      rank        = 5
      x_pos       = 32
      y_pos       = 18
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric system.disk.io_time | filter ((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric system.disk.operation_time | filter ((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) | rate | group_by [\"direction\"], sum"
      }
    }
    chart {
      name        = "Disk Space Usage"
      description = ""
      type        = "timeseries"
      rank        = 6
      x_pos       = 0
      y_pos       = 26
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric system.filesystem.utilization | filter ((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) | reduce mean | group_by [\"mountpoint\"], mean | point (value *100.00000) "
      }
    }
    chart {
      name        = "Network Received"
      description = ""
      type        = "timeseries"
      rank        = 7
      x_pos       = 16
      y_pos       = 26
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric system.network.io | filter (((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) && (\"direction\" == \"receive\")) | rate | group_by [\"device\"], mean"
      }
    }
    chart {
      name        = "Network Transmitted"
      description = ""
      type        = "timeseries"
      rank        = 8
      x_pos       = 32
      y_pos       = 26
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric system.network.io | filter (((\"k8s.node.name\" == $k8s_node) && (\"k8s.cluster.name\" == $k8s_cluster)) && (\"direction\" == \"transmit\")) | rate | group_by [\"device\"], sum"
      }
    }
  }

  template_variable {
    name                     = "k8s_node"
    default_values           = []
    suggestion_attribute_key = "k8s.node.name"
  }
  template_variable {
    name                     = "k8s_cluster"
    default_values           = []
    suggestion_attribute_key = "k8s.cluster.name"
  }
}
