terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.62.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "k8s_kubelet_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "Kubelet (imported)"

  chart {
    name = "Running Kubelets"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      // NOTE: in the kube-prometheus-stack Grafana templates a big_number is used for display
      display = "line"
      hidden  = false

      metric              = "kubelet_node_name"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Running Pods"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "a"
      // NOTE: in the kube-prometheus-stack Grafana templates a big_number is used for display
      display = "line"
      hidden  = false

      metric              = "kubelet_running_pods"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Running Containers"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "a"
      // NOTE: in the kube-prometheus-stack Grafana templates a big_number is used for display
      display = "line"
      hidden  = false

      metric              = "kubelet_running_containers"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Actual Volume Count"
    rank = "3"
    type = "timeseries"

    query {
      query_name = "a"
      // NOTE: in the kube-prometheus-stack Grafana templates a big_number is used for display
      display = "line"
      hidden  = false

      metric              = "volume_manager_total_volumes"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Desired Volume Count"
    rank = "4"
    type = "timeseries"

    query {
      query_name = "a"
      // NOTE: in the kube-prometheus-stack Grafana templates a big_number is used for display
      display = "line"
      hidden  = false

      metric              = "volume_manager_total_volumes"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Operation Rate"
    rank = "5"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "kubelet_runtime_operations_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["operation_type", ]
      }

    }

  }

  chart {
    name = "Operation Error Rate"
    rank = "6"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "kubelet_runtime_operations_errors_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Operation duration (p99)"
    rank = "7"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "kubelet_runtime_operations_duration_seconds"
      timeseries_operator = "delta"


      group_by {
        aggregation_method = "sum"
        keys               = ["instance", "operation_type", ]
      }

    }

  }

  chart {
    name = "Pod Start Duration (p95)"
    rank = "8"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "kubelet_pod_worker_duration_seconds"
      timeseries_operator = "delta"


      group_by {
        aggregation_method = "sum"
        keys               = ["service", ]
      }

    }

    query {
      query_name = "b"
      display    = "line"
      hidden     = false

      metric              = "kubelet_pod_start_duration_seconds"
      timeseries_operator = "delta"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Storage Operation Duration (p99)"
    rank = "9"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "storage_operation_duration_seconds"
      timeseries_operator = "delta"


      group_by {
        aggregation_method = "sum"
        keys               = ["instance", "operation_name", "volume_plugin", ]
      }

    }

  }

  chart {
    name = "Cgroup manager duration seconds (p99)"
    rank = "10"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "kubelet_cgroup_manager_duration_seconds"
      timeseries_operator = "delta"


      group_by {
        aggregation_method = "sum"
        keys               = ["instance", "operation_type", ]
      }

    }

  }

  chart {
    name = "PLEG relist interval (p99)"
    rank = "11"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "kubelet_pleg_relist_interval_seconds"
      timeseries_operator = "delta"


      group_by {
        aggregation_method = "sum"
        keys               = ["instance", ]
      }

    }

  }

  chart {
    name = "PLEG relist duration (p99)"
    rank = "12"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "kubelet_pleg_relist_duration_seconds"
      timeseries_operator = "delta"


      group_by {
        aggregation_method = "sum"
        keys               = ["instance", ]
      }

    }

  }

  chart {
    name = "RPC Rates (2xx, 4xx, 5xx)"
    rank = "13"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "rest_client_requests_total"
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

      metric              = "rest_client_requests_total"
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

      metric              = "rest_client_requests_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "Request duration (p99)"
    rank = "14"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "rest_client_request_duration_seconds"
      timeseries_operator = "delta"


      group_by {
        aggregation_method = "sum"
        keys               = ["verb", ]
      }

    }

  }

  chart {
    name = "Memory"
    rank = "15"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "process_resident_memory_bytes"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = []
      }

    }

  }

  chart {
    name = "CPU Usage"
    rank = "16"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "process_cpu_seconds_total"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "avg"
        keys               = ["instance", ]
      }

    }

  }

  chart {
    name = "Goroutines"
    rank = "17"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "go_goroutines"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "avg"
        keys               = ["instance", ]
      }

    }

  }

}
