terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.84.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_kubernetes_comprehensive_dashboard_otel_native" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry Collector Comprehensive Kubernetes Dashboard (OTel metrics)"
  dashboard_description = "A comprehensive dashboard for monitoring Kubernetes clusters using the OpenTelemetry Collector with OTel native metrics"

  group {
    rank            = 3
    title           = "Deployments"
    visibility_type = "explicit"

    chart {
      name   = "Deployment Replicas Available"
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
        query_string = "metric k8s.deployment.available | filter (k8s.namespace.name == $namespace) | latest | group_by [], sum"
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
        query_string = "with a = metric k8s.deployment.available | filter (k8s.namespace.name == $namespace) | latest 5m | group_by [], sum; b = metric k8s.deployment.desired | filter (k8s.namespace.name == $namespace) | latest 5m | group_by [], sum; join b-a"
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
        query_string = "metric k8s.node.cpu.utilization | filter k8s.node.name == $node | latest | group_by [], count"
      }
      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric k8s.node.condition_ready | filter k8s.node.name == $node | latest | group_by [\"k8s.node.name\"], sum"
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
        query_string = "metric k8s.node.condition_ready | latest | group_by [\"k8s.node.name\"], sum | point_filter value == 1"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.node.condition_ready | time_shift 15m | latest | group_by [\"k8s.node.name\"], sum | point_filter value == 1"
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
        query_string = "metric k8s.job.active_pods | filter (k8s.namespace.name == $namespace) | latest 1m | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.job.successful_pods | filter (k8s.namespace.name == $namespace) | rate 1m | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.job.failed_pods | filter (k8s.namespace.name == $namespace) | rate 1m | group_by [], sum"
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
        query_string = "metric k8s.job.successful_pods | filter k8s.namespace.name == $namespace | latest | group_by [], sum"
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
        query_string = "metric k8s.job.failed_pods | filter k8s.namespace.name == $namespace | latest | group_by [], sum"
      }
    }
  }

  group {
    rank            = 4
    title           = "Daemonsets"
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
        query_string = "with\n  a = metric kube_daemonset_status_number_available | filter (k8s.namespace.name == $namespace) | latest | group_by [], sum;\n  b = metric kube_daemonset_status_number_unavailable | filter (k8s.namespace.name == $namespace) | latest | group_by [], sum;\njoin ((a + b)), a=0, b=0"
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
        query_string = "metric k8s.daemonset.ready_nodes | filter (k8s.namespace.name == $namespace) | latest | group_by [\"k8s.daemonset.name\", \"k8s.namespace.name\"], sum"
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
        query_string = "metric k8s.daemonset.current_scheduled_nodes | filter k8s.namespace.name == $namespace | latest | group_by [\"k8s.daemonset.name\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.daemonset.desired_scheduled_nodes | filter k8s.namespace.name == $namespace | latest | group_by [\"k8s.daemonset.name\"], sum"
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
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.daemonset.ready_nodes | filter k8s.namespace.name == $namespace | latest | group_by [\"k8s.daemonset.name\"], sum"
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
        query_string = "with\n  a = metric k8s.node.cpu.utilization | filter k8s.node.name == $node | latest | group_by [], sum;\n  b = metric k8s.node.allocatable_cpu | filter k8s.node.name == $node | latest | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
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
        query_string = "with\n  a = metric k8s.node.memory.usage | filter k8s.node.name == $node | latest | group_by [], sum;\n  b = metric k8s.node.allocatable_memory | filter k8s.node.name == $node | latest | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
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
        query_string = "metric k8s.node.cpu.utilization | filter k8s.node.name == $node | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.node.allocatable_cpu | filter k8s.node.name == $node | latest | group_by [], sum"
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
        query_string = "metric k8s.node.memory.usage | filter k8s.node.name == $node | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.node.allocatable_memory | filter k8s.node.name == $node| latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.node.memory.available | filter k8s.node.name == $node | latest | group_by [], sum"
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
        query_string = "with\n  a = metric k8s.node.filesystem.usage | latest | group_by [], sum;\n  b = metric k8s.node.filesystem.capacity | latest | group_by [], sum;\njoin (((a/b)*100)), a=0, b=0"
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
        query_string = "metric k8s.node.network.io | rate | group_by [], sum | point value > 0"
      }
    }
    chart {
      name   = "Node Disk Capacity"
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
        query_string = "metric k8s.node.filesystem.available | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Network Usage (bytes/s)"
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
        query_string = "metric k8s.node.network.io | rate | group_by [\"direction\"], sum"
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

        hidden       = false
        query_string = "metric k8s.pod.phase | filter ((k8s.namespace.name == $namespace) && (k8s.node.name == $node)) | latest | group_by [\"k8s.namespace.name\"], count_nonzero"
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

      #  k8s.pod.phase represents current phase of the pod (1 - Pending, 2 - Running, 3 - Succeeded, 4 - Failed, 5 - Unknown)
      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.phase | filter k8s.namespace.name == $namespace && k8s.pod.name == $pod | point_filter value == 2 | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.phase | time_shift 15m | filter k8s.namespace.name == $namespace && k8s.pod.name == $pod | point_filter value == 2 | latest | group_by [], sum"
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
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.restarts | filter ((k8s.namespace.name == $namespace) && (k8s.pod.name == $pod)) | rate | group_by [], sum"
      }
      query {
        query_name   = "e"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.ready | filter ((k8s.namespace.name == $namespace) && (k8s.pod.name == $pod)) | latest | group_by [], sum"
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
        query_string = "metric kube_pod_container_resource_limits | filter (((((resource == \"cpu\") && (k8s.pod.name == $pod)) && (k8s.node.name == $node)) && (unit == \"core\")) && (k8s.namespace.name == $namespace)) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_capacity | filter (((resource == \"cpu\") && (k8s.node.name == $node)) && (unit == \"core\")) | latest | group_by [], sum"
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
        query_string = "metric kube_pod_container_resource_limits | filter (((((k8s.pod.name == $pod) && (k8s.node.name == $node)) && (k8s.namespace.name == $namespace)) && (resource == \"memory\")) && (unit == \"byte\")) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric kube_node_status_capacity | filter (((resource == \"memory\") && (k8s.node.name == $node)) && (unit == \"byte\")) | latest | group_by [], sum"
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
        query_string = "metric k8s.container.restarts | filter ((k8s.namespace.name == $namespace) && (k8s.pod.name == $pod)) | rate | group_by [\"k8s.namespace.name\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.restarts | time_shift 30m | filter ((k8s.namespace.name == $namespace) && (k8s.pod.name == $pod)) | rate | group_by [\"k8s.namespace.name\"], sum"
      }
    }
    chart {
      name   = "Containers CPU Utilization"
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
        query_string = "metric container.cpu.utilization | filter k8s.namespace.name == $namespace && k8s.node.name == $node && k8s.pod.name == $pod  | latest | group_by [], sum"
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
        query_string = "metric k8s.container.memory_request | filter (((((k8s.namespace.name == $namespace) && (k8s.node.name == $node)) && (k8s.pod.name == $pod)))) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.memory_limit | filter (((((k8s.namespace.name == $namespace) && (k8s.node.name == $node)) && (k8s.pod.name == $pod)))) | latest | group_by [], sum"
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

        hidden       = false
        query_string = "metric k8s.container.ready | filter ((k8s.namespace.name == $namespace) && (k8s.pod.name == $pod)) | latest | group_by [\"k8s.namespace.name\"], sum"
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
        query_string = "metric k8s.namespace.phase | latest | group_by [\"k8s.namespace.name\"], sum | point_filter value == 1 | group_by [], count_nonzero"
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
        query_string = "metric k8s.statefulset.current_pods | filter (k8s.namespace.name == $namespace) | latest | group_by [], count_nonzero"
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
        query_string = "metric k8s.volume.capacity | filter (k8s.namespace.name == $namespace) | latest | group_by [\"k8s.persistentvolumeclaim.name\"], count_nonzero"
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
        query_string = "metric k8s.volume.capacity | filter (k8s.namespace.name == $namespace)| latest | group_by [\"k8s.volume.name\"], count_nonzero | group_by [], sum"
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
}

