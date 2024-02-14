terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.1"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_kubernetes_comprehensive_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Kubernetes Comprehensive"
  dashboard_description = "A comprehensive dashboard for monitoring Kubernetes metrics outputted by the OpenTelemetry collectors set up with the [otel-cloud-stack](https://github.com/lightstep/otel-collector-charts/tree/main/charts/otel-cloud-stack) collector config, which includes the [k8sclusterreceiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/k8sclusterreceiver) and [kubeletstatsreceiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/kubeletstatsreceiver)."


  group {
    rank            = 1
    title           = "Nodes"
    visibility_type = "explicit"

    chart {
      name   = "Node Readiness"
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
        query_string = "metric k8s.node.condition_ready | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node | latest | group_by [\"k8s.node.name\"], sum"
      }
    }
    chart {
      name   = "Node CPU Usage (%)"
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
        query_string = "with\n  a = metric k8s.node.cpu.utilization | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node | latest | group_by [], sum;\n  b = metric k8s.node.allocatable_cpu | filter k8s.node.name == $node | latest | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Node Memory Usage (%)"
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
        query_string = "with\n  a = metric k8s.node.memory.usage | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node | latest | group_by [], sum;\n  b = metric k8s.node.allocatable_memory | filter k8s.node.name == $node | latest | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }

    chart {
      name   = "Node CPU Capacity"
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
        query_string = "metric k8s.node.cpu.utilization | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.node.allocatable_cpu | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node | latest | group_by [], sum"
      }
    }

    chart {
      name   = "Node Memory Capacity"
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
        query_string = "metric k8s.node.memory.usage | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node  | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.node.allocatable_memory | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.node.memory.available | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Node Disk Usage (%)"
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
        query_string = "with\n  a = metric k8s.node.filesystem.usage | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node | latest | group_by [], sum;\n  b = metric k8s.node.filesystem.capacity | filter k8s.cluster.name == $cluster | latest | group_by [], sum;\njoin (((a/b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Node Disk Capacity"
      type   = "timeseries"
      rank   = 6
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8


      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.node.filesystem.available | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Node Network Usage (bytes/s)"
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
        query_string = "metric k8s.node.network.io | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node | rate | group_by [\"direction\"], sum"
      }
    }
  }
  group {
    rank            = 2
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
        display      = "line"
        hidden       = false
        query_string = "metric k8s.deployment.available | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [], sum"
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
        display      = "line"
        hidden       = false
        query_string = "with a = metric k8s.deployment.available | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest 5m | group_by [], sum; b = metric k8s.deployment.desired | filter (k8s.namespace.name == $namespace) | latest 5m | group_by [], sum; join b-a"
      }
    }
  }
  group {
    rank            = 3
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
        query_string = "metric k8s.job.active_pods | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest 1m | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.job.successful_pods | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | rate 1m | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.job.failed_pods | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | rate 1m | group_by [], sum"
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
        display      = "line"
        hidden       = false
        query_string = "metric k8s.job.successful_pods | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [], sum"
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
        display      = "line"
        hidden       = false
        query_string = "metric k8s.job.failed_pods | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [], sum"
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
        display      = "line"
        hidden       = false
        query_string = "metric k8s.daemonset.ready_nodes | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Daemonsets Ready By Namespace"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric k8s.daemonset.ready_nodes | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [\"k8s.namespace.name\", \"k8s.daemonset.name\"], sum"
      }
    }
    chart {
      name   = "Daemonsets Schedules"
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
        query_string = "metric k8s.daemonset.current_scheduled_nodes | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [\"k8s.daemonset.name\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.daemonset.desired_scheduled_nodes | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [\"k8s.daemonset.name\"], sum"
      }
    }
    chart {
      name   = "Daemonsets Status"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.daemonset.name | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [\"k8s.daemonset.name\"], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.daemonset.ready_nodes | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [\"k8s.daemonset.name\"], sum"
      }
    }
  }
  group {
    rank            = 5
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
        query_string = "metric k8s.pod.phase | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node | latest | group_by [\"k8s.namespace.name\"], count_nonzero"
      }
    }
    chart {
      name   = "Pods Ready"
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
        query_string = "metric k8s.pod.phase | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.pod.name == $pod | point_filter value == 2 | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.phase | time_shift 15m | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.pod.name == $pod | point_filter value == 2 | latest | group_by [], sum"
      }
    }
  }
  group {
    rank            = 6
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
        query_string = "metric k8s.container.restarts | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.pod.name == $pod | rate | group_by [], sum"
      }
      query {
        query_name   = "e"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.ready | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.pod.name == $pod | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Containers Readiness Flapping (Restarts)"
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
        query_string = "metric k8s.container.restarts | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.pod.name == $pod | rate | group_by [\"k8s.namespace.name\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.restarts | time_shift 30m | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.pod.name == $pod | rate | group_by [\"k8s.namespace.name\"], sum"
      }
    }
    chart {
      name   = "Containers CPU Utilization"
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
        query_string = "metric container.cpu.utilization | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node && k8s.pod.name == $pod  | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Containers Memory Requests"
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
        query_string = "metric k8s.container.memory_request | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node && k8s.pod.name == $pod | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.memory_limit | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.node.name == $node && k8s.pod.name == $pod | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Total Containers By Namespace"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name = "a"
        display    = "table"

        hidden       = false
        query_string = "metric k8s.container.ready | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && k8s.pod.name == $pod | latest | group_by [\"k8s.namespace.name\"], sum"
      }
    }
  }
  group {
    rank            = 0
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
        display      = "line"
        hidden       = false
        query_string = "metric k8s.namespace.phase | filter k8s.cluster.name == $cluster | latest | group_by [\"k8s.namespace.name\"], sum | point_filter value == 1 | group_by [], count_nonzero"
      }
    }
    chart {
      name   = "Total Statefulsets"
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
        query_string = "metric k8s.statefulset.current_pods | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [], count_nonzero"
      }
    }
    chart {
      name   = "Total Persistent Volume Claims"
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
        query_string = "metric k8s.volume.capacity | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [\"k8s.persistentvolumeclaim.name\"], count_nonzero"
      }
    }
    chart {
      name   = "Total Persistent Volume"
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
        query_string = "metric k8s.volume.capacity | filter k8s.cluster.name == $cluster && k8s.namespace.name == $namespace | latest | group_by [\"k8s.volume.name\"], count_nonzero | group_by [], sum"
      }
    }
  }


  template_variable {
    name                     = "pod"
    default_values           = []
    suggestion_attribute_key = "k8s.pod.name"
  }
  template_variable {
    name                     = "namespace"
    default_values           = []
    suggestion_attribute_key = "k8s.namespace.name"
  }
  template_variable {
    name                     = "node"
    default_values           = []
    suggestion_attribute_key = "k8s.node.name"
  }
  template_variable {
    name                     = "cluster"
    default_values           = []
    suggestion_attribute_key = "k8s.cluster.name"
  }
}