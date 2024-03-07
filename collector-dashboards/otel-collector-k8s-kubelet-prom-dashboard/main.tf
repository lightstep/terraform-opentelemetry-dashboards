terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.92.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "k8s_kubelet_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "K8S Kubelet (Prometheus)"
  dashboard_description = "Monitor your K8S Kubelets with this overview dashboard where charts are powered by `kubelet_*` [metrics from Kubernetes](https://kubernetes.io/docs/reference/instrumentation/metrics/) that expose the metric data in Prometheus format."

  chart {
    name = "Running Kubelets"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kubelet_node_name | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Running Pods"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kubelet_running_pods | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Running Containers"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kubelet_running_containers | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Actual Volume Count"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric volume_manager_total_volumes | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Desired Volume Count"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric volume_manager_total_volumes | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Operation Rate"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kubelet_runtime_operations_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by ["operation_type"], sum
EOT
    }

  }

  chart {
    name = "Operation Error Rate"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kubelet_runtime_operations_errors_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Operation Duration (p99)"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kubelet_runtime_operations_duration_seconds | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | delta | group_by ["instance", "operation_type"], sum | point percentile(value, 99.0)
EOT
    }

  }

  chart {
    name = "Pod Start Duration (p95)"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kubelet_pod_worker_duration_seconds | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | delta | group_by ["service"], sum | point percentile(value, 95.0)
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kubelet_pod_start_duration_seconds | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | delta | group_by [], sum | point percentile(value, 95.0)
EOT
    }

  }

  chart {
    name = "Storage Operation Duration (p99)"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric storage_operation_duration_seconds | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | delta | group_by ["instance", "operation_name", "volume_plugin"], sum | point percentile(value, 99.0)
EOT
    }

  }

  chart {
    name = "Cgroup Manager Duration Seconds (p99)"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kubelet_cgroup_manager_duration_seconds | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | delta | group_by ["instance", "operation_type"], sum | point percentile(value, 99.0)
EOT
    }

  }

  chart {
    name = "PLEG Relist Interval (p99)"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kubelet_pleg_relist_interval_seconds | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | delta | group_by ["instance"], sum | point percentile(value, 99.0)
EOT
    }

  }

  chart {
    name = "PLEG Relist Duration (p99)"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kubelet_pleg_relist_duration_seconds | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | delta | group_by ["instance"], sum | point percentile(value, 99.0)
EOT
    }

  }

  chart {
    name = "RPC Rates (2xx, 4xx, 5xx)"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric rest_client_requests_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by [], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric rest_client_requests_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by [], sum
EOT
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric rest_client_requests_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Request Duration (p99)"
    rank = "14"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric rest_client_request_duration_seconds | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | delta | group_by ["verb"], sum | point percentile(value, 99.0)
EOT
    }

  }

  chart {
    name = "Memory"
    rank = "15"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric process_resident_memory_bytes | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "CPU Usage"
    rank = "16"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric process_cpu_seconds_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | rate | group_by ["instance"], mean
EOT
    }

  }

  chart {
    name = "Goroutines"
    rank = "17"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric go_goroutines | filter ((service.name == $service_name) && (net.host.name == $net_host_name)) | latest | group_by ["instance"], mean
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
