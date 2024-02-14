terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.1"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_kubernetes_comprehensive_dashboard_prometheus" {
  project_name          = var.lightstep_project
  dashboard_name        = "Kubernetes Comprehensive (Prometheus)"
  dashboard_description = "A comprehensive dashboard that monitors a Kubernetes cluster running an OpenTelemetry Collector that scrapes [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics) with a [prometheus receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/prometheusreceiver)."
  group {
    rank            = 3
    title           = "Deployments"
    visibility_type = "explicit"

    chart {
      name   = "Deployment Replicas Total"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_deployment_status_replicas | filter (namespace == $namespace) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Deployment Replicas Unavailable"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_deployment_status_replicas_unavailable | filter (namespace == $namespace) | latest 5m | group_by [], sum"
      }
    }
    chart {
      name   = "Deployment Replicas Status"
      type   = "timeseries"
      rank   = 2
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_deployment_status_replicas | filter (namespace == $namespace) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_deployment_status_replicas_available | filter (namespace == $namespace) | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric kube_deployment_status_replicas_ready | filter (namespace == $namespace) | latest | group_by [], sum"
      }
      query {
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric kube_deployment_status_replicas_unavailable | filter (namespace == $namespace) | latest | group_by [], sum"
      }
      query {
        query_name   = "e"
        display      = "line"
        hidden       = false
        query_string = "metric kube_deployment_status_replicas_updated | filter (namespace == $namespace) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Deployments Condition"
      type   = "timeseries"
      rank   = 3
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_deployment_status_condition | filter ((namespace == $namespace) && (((status == \"true\") || (status == 1)) || (status == 1.0))) | latest | group_by [\"condition\"], sum"
      }
    }
    chart {
      name   = "Deployments Available By Namespace"
      type   = "timeseries"
      rank   = 5
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric kube_deployment_status_condition | filter (((namespace == $namespace) && (condition == \"Available\")) && (((status == \"true\") || (status == 1)) || (status == 1.0))) | latest | group_by [\"namespace\", \"deployment\"], sum"
      }
    }
  }
  group {
    rank            = 5
    title           = "Nodes"
    visibility_type = "explicit"

    chart {
      name   = "Nodes Total"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_node_info | filter (node == $node) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Nodes Unavailable"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_node_spec_unschedulable | filter (node == $node) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Nodes Readiness Flapping (Restarts)"
      type   = "timeseries"
      rank   = 2
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_condition | filter (((node == $node) && (condition == \"Ready\")) && (((status == \"true\") || (status == 1)) || (status == 1.0))) | latest | group_by [\"node\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_condition | time_shift 15m | filter (((node == $node) && (condition == \"Ready\")) && (((status == \"true\") || (status == 1)) || (status == 1.0))) | latest | group_by [\"node\"], sum"
      }
    }
    chart {
      name   = "Nodes Condition"
      type   = "timeseries"
      rank   = 3
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_condition | filter ((node == $node) && (((status == \"true\") || (status == 1)) || (status == 1.0))) | latest | group_by [\"condition\"], sum"
      }
    }
  }
  group {
    rank            = 7
    title           = "Jobs"
    visibility_type = "explicit"

    chart {
      name   = "Batch Jobs Rate"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_job_status_active | filter (namespace == $namespace) | latest 1m | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_job_status_succeeded | filter (namespace == $namespace) | rate 1m | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric kube_job_status_failed | filter (namespace == $namespace) | rate 1m | group_by [], sum"
      }
    }
    chart {
      name   = "Batch Jobs Total Succeeded"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_job_status_succeeded | filter (namespace == $namespace) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Batch Jobs Total Failed"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_job_status_failed | filter (namespace == $namespace) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Cron Jobs Total"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_cronjob_info | filter (namespace == $namespace) | latest | group_by [], count_nonzero"
      }
    }
  }
  group {
    rank            = 4
    title           = "New Section"
    visibility_type = "explicit"

    chart {
      name   = "Daemonsets Total"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric kube_daemonset_status_number_available | filter (namespace == $namespace) | latest | group_by [], sum;\n  b = metric kube_daemonset_status_number_unavailable | filter (namespace == $namespace) | latest | group_by [], sum;\njoin ((a + b)), a=0, b=0"
      }
    }
    chart {
      name   = "Daemonset Unavailable"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_daemonset_status_number_unavailable | filter (namespace == $namespace) | latest 5m | group_by [], sum"
      }
    }
    chart {
      name   = "Daemonsets Ready By Namespace"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric kube_daemonset_status_number_ready | filter (namespace == $namespace) | latest | group_by [\"daemonset\", \"namespace\"], sum"
      }
    }
    chart {
      name   = "Daemonsets Schedules"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_daemonset_status_current_number_scheduled | filter (namespace == $namespace) | latest | group_by [\"daemonset\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_daemonset_status_desired_number_scheduled | filter (namespace == $namespace) | latest | group_by [\"daemonset\"], sum"
      }
    }
    chart {
      name   = "Daemonsets Status"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_daemonset_status_number_misscheduled | filter (namespace == $namespace) | latest | group_by [\"daemonset\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_daemonset_status_number_available | filter (namespace == $namespace) | latest | group_by [\"daemonset\"], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric kube_daemonset_status_number_ready | filter (namespace == $namespace) | latest | group_by [\"daemonset\"], sum"
      }
      query {
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric kube_daemonset_status_number_unavailable | filter (namespace == $namespace) | latest | group_by [\"daemonset\"], sum"
      }
    }
  }
  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"
  }
  group {
    rank            = 2
    title           = "Cluster Health"
    visibility_type = "explicit"

    chart {
      name   = "Cluster Pod Usage (%)"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric kube_pod_info | filter (node == $node) | latest | group_by [], sum;\n  b = metric kube_node_status_allocatable | filter ((resource == \"pods\") && (node == $node)) | latest | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Cluster CPU Usage (%)"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric kube_pod_container_resource_requests | filter ((resource == \"cpu\") && (node == $node)) | latest | group_by [], sum;\n  b = metric kube_node_status_allocatable | filter ((resource == \"cpu\") && (node == $node)) | latest | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Cluster Memory Usage (%)"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric kube_pod_container_resource_requests | filter (((resource == \"memory\") && (node == $node)) && (unit == \"byte\")) | latest | group_by [], sum;\n  b = metric kube_node_status_allocatable | filter (((resource == \"memory\") && (node == $node)) && (unit == \"byte\")) | latest | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Cluster Pod Capacity"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_info | filter (node == $node) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_allocatable | filter ((resource == \"pods\") && (node == $node)) | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_capacity | filter ((resource == \"pods\") && (node == $node)) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Cluster CPU Capacity"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_resource_requests | filter ((resource == \"cpu\") && (node == $node)) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_allocatable | filter ((resource == \"cpu\") && (node == $node)) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Cluster Memory Capacity"
      type   = "timeseries"
      rank   = 5
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_resource_requests | filter (((resource == \"memory\") && (node == $node)) && (unit == \"byte\")) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_allocatable | filter (((resource == \"memory\") && (node == $node)) && (unit == \"byte\")) | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_capacity | filter (((resource == \"memory\") && (node == $node)) && (unit == \"byte\")) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Cluster Disk Usage (%)"
      type   = "timeseries"
      rank   = 6
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric node_filesystem_size_bytes | filter (device !~ \"rootfs\") | latest | group_by [], sum;\n  b = metric node_filesystem_free_bytes | filter (device !~ \"rootfs\") | latest | group_by [], sum;\njoin ((((a - b)/ a)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Network Operational Status"
      type   = "timeseries"
      rank   = 7
      x_pos  = 16
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric node_network_up | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric node_network_carrier | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Cluster Disk Capacity"
      type   = "timeseries"
      rank   = 8
      x_pos  = 0
      y_pos  = 24
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric node_filesystem_size_bytes | filter (device !~ \"rootfs\") | latest | group_by [], sum;\n  b = metric node_filesystem_free_bytes | filter (device !~ \"rootfs\") | latest | group_by [], sum;\njoin ((a - b)), a=0, b=0"
      }
    }
    chart {
      name   = "Network Usage"
      type   = "timeseries"
      rank   = 9
      x_pos  = 16
      y_pos  = 24
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric node_network_receive_bytes | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric node_network_transmit_bytes | rate | group_by [], sum"
      }
    }
  }
  group {
    rank            = 6
    title           = "Pods"
    visibility_type = "explicit"

    chart {
      name   = "Total Pods By Namespace"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name = "a"
        display    = "table"

        # display_type_options {
        #   sort_by        = "value"
        #   sort_direction = "desc"
        # }
        hidden       = false
        query_string = "metric kube_pod_info | filter ((namespace == $namespace) && (node == $node)) | latest | group_by [\"namespace\"], sum"
      }
    }
    chart {
      name   = "Pods Readiness Flapping (Restarts)"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_status_ready | filter (((((condition == \"true\") || (condition == 1)) || (condition == 1.0)) && (namespace == $namespace)) && (pod == $pod)) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_status_ready | time_shift 15m | filter (((((condition == \"true\") || (condition == 1)) || (condition == 1.0)) && (namespace == $namespace)) && (pod == $pod)) | latest | group_by [], sum"
      }
    }
  }
  group {
    rank            = 8
    title           = "Containers"
    visibility_type = "explicit"

    chart {
      name   = "Containers Status"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_status_running | filter ((namespace == $namespace) && (pod == $pod)) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_status_waiting | filter ((namespace == $namespace) && (pod == $pod)) | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_status_terminated | filter ((namespace == $namespace) && (pod == $pod)) | latest | group_by [], sum"
      }
      query {
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_status_restarts | filter ((namespace == $namespace) && (pod == $pod)) | rate | group_by [], sum"
      }
      query {
        query_name   = "e"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_status_ready | filter ((namespace == $namespace) && (pod == $pod)) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Containers CPU Overcommit"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_resource_limits | filter (((((resource == \"cpu\") && (pod == $pod)) && (node == $node)) && (unit == \"core\")) && (namespace == $namespace)) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_capacity | filter (((resource == \"cpu\") && (node == $node)) && (unit == \"core\")) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Containers Memory Overcommit"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_resource_limits | filter (((((pod == $pod) && (node == $node)) && (namespace == $namespace)) && (resource == \"memory\")) && (unit == \"byte\")) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_capacity | filter (((resource == \"memory\") && (node == $node)) && (unit == \"byte\")) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Containers Readiness Flapping (Restarts)"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_status_restarts | filter ((namespace == $namespace) && (pod == $pod)) | rate | group_by [\"namespace\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_status_restarts | time_shift 30m | filter ((namespace == $namespace) && (pod == $pod)) | rate | group_by [\"namespace\"], sum"
      }
    }
    chart {
      name   = "Containers CPU Requests"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_resource_requests | filter (((((namespace == $namespace) && (node == $node)) && (pod == $pod)) && (resource == \"cpu\")) && (unit == \"core\")) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_capacity | filter (((resource == \"cpu\") && (node == $node)) && (unit == \"core\")) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Containers Memory Requests"
      type   = "timeseries"
      rank   = 5
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric kube_pod_container_resource_requests | filter (((((namespace == $namespace) && (node == $node)) && (pod == $pod)) && (resource == \"memory\")) && (unit == \"byte\")) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_capacity | filter (((resource == \"memory\") && (node == $node)) && (unit == \"byte\")) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Total Containers By Namespace"
      type   = "timeseries"
      rank   = 6
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name = "a"
        display    = "table"

        # display_type_options {
        #   sort_by        = "value"
        #   sort_direction = "desc"
        # }
        hidden       = false
        query_string = "metric kube_pod_container_info | filter ((namespace == $namespace) && (pod == $pod)) | latest | group_by [\"namespace\"], sum"
      }
    }
  }
  group {
    rank            = 1
    title           = "Cluster Overview"
    visibility_type = "explicit"

    chart {
      name   = "Total Active Namespaces"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_namespace_status_phase | filter ((phase == \"Active\") && (namespace == $namespace)) | latest | group_by [], count_nonzero"
      }
    }
    chart {
      name   = "Total Secrets"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_secret_info | filter (namespace == $namespace) | latest | group_by [], count_nonzero"
      }
    }
    chart {
      name   = "Total ConfigMaps"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_configmap_info | filter (namespace == $namespace) | latest | group_by [], count_nonzero"
      }
    }
    chart {
      name   = "Total Services"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_service_info | filter (namespace == $namespace) | latest | group_by [], count_nonzero"
      }
    }
    chart {
      name   = "Total Statefulsets"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_statefulset_status_replicas_current | filter (namespace == $namespace) | latest | group_by [], count_nonzero"
      }
    }
    chart {
      name   = "Total Persistent Volume Claims"
      type   = "timeseries"
      rank   = 5
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_persistentvolumeclaim_info | filter (namespace == $namespace) | latest | group_by [], count_nonzero"
      }
    }
    chart {
      name   = "Total Persistent Volume"
      type   = "timeseries"
      rank   = 6
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric kube_persistentvolume_info | latest | group_by [], count_nonzero"
      }
    }
    chart {
      name   = "Storage Classes"
      type   = "timeseries"
      rank   = 7
      x_pos  = 16
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric kube_storageclass_info | latest | group_by [\"storageclass\", \"provisioner\", \"volume_binding_mode\"], sum"
      }
    }
    chart {
      name   = "Ingress Classes"
      type   = "timeseries"
      rank   = 8
      x_pos  = 32
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric kube_ingressclass_info | rate | group_by [\"ingressclass\"], sum"
      }
    }
  }

  template_variable {
    name                     = "pod"
    default_values           = []
    suggestion_attribute_key = "pod"
  }
  template_variable {
    name                     = "namespace"
    default_values           = []
    suggestion_attribute_key = "namespace"
  }
  template_variable {
    name                     = "node"
    default_values           = []
    suggestion_attribute_key = "node"
  }
}
