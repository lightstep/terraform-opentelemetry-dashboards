terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_kubernetes_application_dashboard" {
  dashboard_name        = "Kubernetes Application"
  project_name          = var.cloud_observability_project
  dashboard_description = "This dashboard is a generic kubernetes application and machine dashboard, which uses OTEL receivers (k8scluster, hostmetrics, kubeletstats) to generate infrastructure metrics."

  group {
    rank            = 1
    title           = "CPU"
    visibility_type = "explicit"

    chart {
      name        = "CPU Cores Used, Requests, and Limits"
      description = "Displays pod CPU time, CPU requests and CPU limits "
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.cpu.time | filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) | rate | group_by [\"k8s.namespace.name\", \"k8s.pod.name\", \"k8s.app.instance\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.cpu_request | filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) | align 30s | group_by [\"k8s.namespace.name\", \"k8s.app.instance\"], mean"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.cpu_limit | filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) | align 30s | group_by [\"k8s.namespace.name\", \"k8s.app.instance\"], mean"
      }
    }
    chart {
      name        = "CPU Usage % of Requests"
      description = "Uses pod CPU utilization and CPU requests to find what percentage of a resource is being used"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n\tusage = metric k8s.pod.cpu.utilization\n\t\t| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n\t\t| reduce 30s, mean\n\t\t| group_by [\"k8s.namespace.name\", \"k8s.pod.name\", \"k8s.app.instance\"], sum;\n\trequests = metric k8s.container.cpu_request\n\t\t| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n\t\t| align 30s\n\t\t| group_by [\"k8s.namespace.name\", \"k8s.app.instance\"], max;\njoin usage / requests * 100"
      }
    }
    chart {
      name   = "CFS Throttling: % of CPU time throttled"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 4

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n  pods = metric k8s.pod.cpu.time | filter k8s.cluster.uid == $cluster | filter service.name == $service && k8s.app.instance == $kube_app_instance && k8s.namespace.name == $namespace | reduce 30s, max | group_by [\"k8s.namespace.name\", \"k8s.pod.name\"], sum | point value * 0;\n  throttled_secs = metric container_cpu_cfs_throttled_seconds_total | filter k8s.cluster.uid == $cluster | filter k8s.namespace.name == $namespace | rate | group_by [\"k8s.namespace.name\", \"k8s.pod.name\"], sum;\n  total_secs = metric container_cpu_cfs_periods_total | filter k8s.cluster.uid == $cluster | filter k8s.namespace.name == $namespace | rate | group_by [\"k8s.namespace.name\", \"k8s.pod.name\"], sum;\njoin throttled_secs / total_secs + pods"
      }
    }
    chart {
      name        = "CPU Usage % of Requests (mean, 1m)"
      description = "Displays pod CPU utilization and CPU requests mean and max in percentages"
      type        = "timeseries"
      rank        = 3
      x_pos       = 32
      y_pos       = 4
      width       = 16
      height      = 4

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n\tusage = metric k8s.pod.cpu.utilization\n\t\t| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n\t\t| reduce 1m, mean\n\t\t| group_by [\"k8s.namespace.name\", \"k8s.app.instance\"], mean;\n\trequests = metric k8s.container.cpu_request\n\t\t| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n\t\t| align 30s\n\t\t| group_by [\"k8s.namespace.name\", \"k8s.app.instance\"], max;\njoin usage / requests * 100"
      }
    }
  }
  group {
    rank            = 2
    title           = "Memory"
    visibility_type = "explicit"

    chart {
      name        = "Memory Used (working set vs. requests)"
      description = "Displays working set memory of pods and memory requests of containers"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.memory.working_set | filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) | latest 30s | group_by [\"k8s.pod.name\", \"k8s.namespace.name\", \"k8s.container.name\", \"k8s.app.instance\"], max\t"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.memory_request | filter ((service.name == $service) && (kube_instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) | latest 30s | group_by [\"k8s.namespace.name\", \"k8s.app.instance\", \"k8s.container.name\"], max\t"
      }
    }
    chart {
      name        = "Memory Used % (working set vs. requests)"
      description = "Displays a percentage of working set memory of pods over memory requests of containers"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n\tusage = metric k8s.pod.memory.working_set\n\t\t| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) \n\t\t| latest 30s \n\t\t| group_by [\"k8s.pod.name\", \"k8s.namespace.name\", \"k8s.container.name\", \"k8s.app.instance\"], max;\n\trequests = metric k8s.container.memory_request\n\t\t| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n\t\t| latest 30s\n\t\t| group_by [\"k8s.namespace.name\", \"k8s.app.instance\"], max;\njoin usage / requests * 100"
      }
    }
    chart {
      name        = "Major Page Faults"
      description = "Number of major page faults"
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 0
      width       = 16
      height      = 4

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.memory.major_page_faults | filter k8s.cluster.uid == $cluster | filter service.name == $service && k8s.app.instance == $kube_app_instance | latest 30s | group_by [\"k8s.namespace.name\", \"k8s.app.instance\", \"k8s.pod.name\"], sum"
      }
    }
    chart {
      name        = "Page Faults"
      description = "Number of page faults"
      type        = "timeseries"
      rank        = 3
      x_pos       = 32
      y_pos       = 4
      width       = 16
      height      = 4

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.memory.page_faults | filter k8s.cluster.uid == $cluster | filter service.name == $service && k8s.app.instance == $kube_app_instance | latest 30s | group_by [\"k8s.namespace.name\", \"k8s.app.instance\", \"k8s.pod.name\"], sum"
      }
    }
  }
  group {
    rank            = 3
    title           = "Lifecycle"
    visibility_type = "explicit"

    chart {
      name        = "Container Restarts"
      description = "Number of container restarts"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 16
      height      = 6

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "# TODO: this needs a \"reason\" label (oom, etc)\nmetric k8s.container.restarts | filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) | latest 1m, 1m | group_by [\"k8s.namespace.name\", \"k8s.app.instance\", \"k8s.pod.name\", \"k8s.container.name\"], sum | delta"
      }
    }
    chart {
      name        = "Pods Running"
      description = "Number of pods running, filtered by instance and namespace"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 0
      width       = 16
      height      = 6

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "# Running\n# 1=Pending 2=Running 3=Succeeded 4=Failed 5=Unknown\nmetric k8s.pod.phase\n\t\t| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n\t\t| latest 30s\n\t\t| point_filter value == 2 \n\t\t| group_by [k8s.namespace.name, k8s.app.instance], count"
      }
    }
    chart {
      name        = "Pods by Phase and Version"
      description = "Number of pods that are running, pending, and other non-running, non-pending pods"
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 0
      width       = 16
      height      = 6

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "# Running\n# 1=Pending 2=Running 3=Succeeded 4=Failed 5=Unknown\nmetric k8s.pod.phase\n\t\t| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n\t\t| latest 30s\n\t\t| point_filter value == 2 \n\t\t| group_by [k8s.namespace.name, k8s.app.instance, service.version], count"
      }
      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "# Pending\n# 1=Pending 2=Running 3=Succeeded 4=Failed 5=Unknown\nmetric k8s.pod.phase\n\t\t| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n\t\t| latest 30s\n\t\t| point_filter value == 1\n\t\t| group_by [k8s.namespace.name, k8s.app.instance, service.version], count"
      }
      query {
        query_name   = "c"
        display      = "bar"
        hidden       = false
        query_string = "# Other (non-running, non-pending)\n# 1=Pending 2=Running 3=Succeeded 4=Failed 5=Unknown\nmetric k8s.pod.phase\n\t\t| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n\t\t| latest 30s\n\t\t| point_filter (value < 1 || value > 2)\n\t\t| group_by [k8s.namespace.name, k8s.app.instance, service.version], count"
      }
    }
  }
  group {
    rank            = 4
    title           = "Network"
    visibility_type = "explicit"

    chart {
      name        = "Network IO Receive by Pod"
      description = "Amount of bytes received (incoming) per pod"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.network.io | filter (((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) && (direction == \"receive\")) | rate | group_by [\"k8s.namespace.name\", \"k8s.app.instance\", \"k8s.pod.name\"], sum\t"
      }
    }
    chart {
      name        = "Network IO Transmit by Pod"
      description = "Amount of bytes transmitted (outgoing) per pod"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.network.io | filter (((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) && (direction == \"transmit\")) | rate | group_by [\"k8s.namespace.name\", \"k8s.app.instance\", \"k8s.pod.name\"], sum\t"
      }
    }
    chart {
      name        = "Network Errors by Pod"
      description = "Displays number of pod network errors occured"
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.network.errors | filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) | rate | group_by [\"k8s.namespace.name\", \"k8s.app.instance\", \"k8s.pod.name\"], sum"
      }
    }
    chart {
      name        = "Network IO Receive (all pods)"
      description = "Amount of bytes received (incoming) for all pods"
      type        = "timeseries"
      rank        = 3
      x_pos       = 0
      y_pos       = 8
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.network.io | filter (((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) && (direction == \"receive\")) | rate | group_by [\"k8s.namespace.name\", \"k8s.app.instance\"], sum\t"
      }
    }
    chart {
      name        = "Network IO Transmit (all pods)"
      description = "Amount of bytes transmitted (outgoing) for all pods"
      type        = "timeseries"
      rank        = 4
      x_pos       = 16
      y_pos       = 8
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.network.io | filter (((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster)) && (direction == \"transmit\")) | rate | group_by [\"k8s.namespace.name\", \"k8s.app.instance\"], sum\t"
      }
    }
  }
  group {
    rank            = 5
    title           = "Spans"
    visibility_type = "explicit"

    chart {
      name        = "Operation Latency"
      description = "The amount of time it takes for an operation to complete"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "spans latency\n| delta\n| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n| group_by [\"operation\"], sum\n| point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)"
      }
    }
    chart {
      name        = "Operation Rate"
      description = "The rate of time it takes for an operation to complete"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "spans count\n| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n| rate\n| group_by [\"operation\"], sum"
      }
    }
    chart {
      name        = "Operation Errors"
      description = "The number of errors in completing an operation "
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n\terrors = spans count\n\t\t| delta\n\t\t| filter ((error == true) && (service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n\t\t| group_by [\"operation\"], sum;\n\ttotal = spans count\n\t\t| delta\n\t\t| filter ((service.name == $service) && (k8s.app.instance == $kube_app_instance) && (k8s.namespace.name == $namespace) && (k8s.cluster.uid == $cluster))\n\t\t| group_by [\"operation\"], sum;\njoin errors / total, errors=0, total=0"
      }
    }
  }
  group {
    rank            = 6
    title           = "Disk Usage"
    visibility_type = "explicit"

    chart {
      name        = "PVC FS Disk Usage %"
      description = "Percentage of filesystem disk usage in PersistentVolume"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n\ttotal = metric k8s.volume.capacity\n\t    | filter service.name == $service && kube_app_instance == $kube_app_instance && k8s.namespace.name == $namespace && k8s.cluster.uid == $cluster && \"k8s.persistentvolumeclaim.name\" =~ \".+\"\n\t\t| latest 30s\n\t\t| group_by [\"k8s.pod.name\", \"k8s.volume.name\", \"k8s.volume.type\", \"k8s.persistentvolumeclaim.name\", \"gce.pd.name\"], sum;\n\tfree = metric k8s.volume.available\n\t\t| filter service.name == $service && kube_app_instance == $kube_app_instance && k8s.namespace.name == $namespace && k8s.cluster.uid == $cluster && \"k8s.persistentvolumeclaim.name\" =~ \".+\"\n\t\t| latest 30s\n\t\t| group_by [\"k8s.pod.name\", \"k8s.volume.name\", \"k8s.volume.type\", \"k8s.persistentvolumeclaim.name\", \"gce.pd.name\"], sum;\njoin (total - free) / total * 100, total=0, free=0"
      }
    }
    chart {
      name        = "PVC FS Disk Usage (bytes)"
      description = "Amount of bytes of filesystem disk usage in PersistentVolume"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n\ttotal = metric k8s.volume.capacity\n\t    | filter service.name == $service && kube_app_instance == $kube_app_instance && k8s.namespace.name == $namespace && k8s.cluster.uid == $cluster && \"k8s.persistentvolumeclaim.name\" =~ \".+\"\n\t\t| latest 30s\n\t\t| group_by [\"k8s.pod.name\", \"k8s.volume.name\", \"k8s.volume.type\", \"k8s.persistentvolumeclaim.name\", \"gce.pd.name\"], sum;\n\tfree = metric k8s.volume.available\n\t\t| filter service.name == $service && kube_app_instance == $kube_app_instance && k8s.namespace.name == $namespace && k8s.cluster.uid == $cluster && \"k8s.persistentvolumeclaim.name\" =~ \".+\"\n\t\t| latest 30s\n\t\t| group_by [\"k8s.pod.name\", \"k8s.volume.name\", \"k8s.volume.type\", \"k8s.persistentvolumeclaim.name\", \"gce.pd.name\"], sum;\njoin (total - free)"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.volume.capacity\n\t    | filter service.name == $service && kube_app_instance == $kube_app_instance && k8s.namespace.name == $namespace && k8s.cluster.uid == $cluster && \"k8s.persistentvolumeclaim.name\" =~ \".+\"\n\t\t| latest 30s\n\t\t| group_by [\"k8s.pod.name\", \"k8s.volume.name\", \"k8s.volume.type\", \"k8s.persistentvolumeclaim.name\", \"gce.pd.name\"], max"
      }
    }
    chart {
      name        = "PVC FS inode Usage %"
      description = "Percentage of filesystem inode usage in PersistentVolume"
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n\ttotal = metric k8s.volume.inodes\n\t    | filter service.name == $service && kube_app_instance == $kube_app_instance && k8s.namespace.name == $namespace && k8s.cluster.uid == $cluster && \"k8s.persistentvolumeclaim.name\" =~ \".+\"\n\t\t| latest 30s\n\t\t| group_by [\"k8s.pod.name\", \"k8s.volume.name\", \"k8s.volume.type\", \"k8s.persistentvolumeclaim.name\", \"gce.pd.name\"], sum;\n\tused = metric k8s.volume.inodes.used\n\t\t| filter service.name == $service && kube_app_instance == $kube_app_instance && k8s.namespace.name == $namespace && k8s.cluster.uid == $cluster && \"k8s.persistentvolumeclaim.name\" =~ \".+\"\n\t\t| latest 30s\n\t\t| group_by [\"k8s.pod.name\", \"k8s.volume.name\", \"k8s.volume.type\", \"k8s.persistentvolumeclaim.name\", \"gce.pd.name\"], sum;\njoin used / total * 100, total=0, used=0"
      }
    }
    chart {
      name        = "Throughput ceiling: Balanced PD"
      description = "Throughput ceiling (max throughput) of balanced persistent disks"
      type        = "timeseries"
      rank        = 3
      x_pos       = 0
      y_pos       = 8
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n\tcapacity_gb = metric k8s.volume.capacity\n\t    | filter service.name == $service && kube_app_instance == $kube_app_instance && k8s.namespace.name == $namespace && k8s.cluster.uid == $cluster && (k8s.volume.type == gcePersistentDisk || k8s.volume.type == csiPersistentVolume)\n\t\t| latest 30s\n\t\t| group_by [\"k8s.pod.name\", \"k8s.volume.name\", \"k8s.volume.type\", \"k8s.persistentvolumeclaim.name\", \"gce.pd.name\"], max\n\t\t| point (value / 1024 / 1024 / 1024);\n\tper_gb = constant 0.28;\n# Throughput is in MB/s\njoin per_gb * capacity_gb * 1024 * 1024"
      }
    }
    chart {
      name        = "Throughput ceiling: SSD PD"
      description = "Throughput ceiling (max throughput) of SSD persistent disks"
      type        = "timeseries"
      rank        = 3
      x_pos       = 16
      y_pos       = 8
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n\tcapacity_gb = metric k8s.volume.capacity\n\t    | filter service.name == $service && kube_app_instance == $kube_app_instance && k8s.namespace.name == $namespace && k8s.cluster.uid == $cluster && (k8s.volume.type == gcePersistentDisk || k8s.volume.type == csiPersistentVolume)\n\t\t| latest 30s\n\t\t| group_by [\"k8s.pod.name\", \"k8s.volume.name\", \"k8s.volume.type\", \"k8s.persistentvolumeclaim.name\", \"gce.pd.name\"], max\n\t\t| point (value / 1024 / 1024 / 1024);\n\tper_gb = constant 0.48;\n# Throughput is in MB/s\njoin per_gb * capacity_gb * 1024 * 1024"
      }
    }
  }
  group {
    rank            = 7
    title           = "Misc"
    visibility_type = "explicit"

    chart {
      name        = "Hourly Active Time Series"
      description = "Lightstep Active Time Series (sequence of timestamped measurements) by hour"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 16
      height      = 6

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric lightstep.hourly_active_time_series\n| filter service.name == $service && kube_app_instance == $kube_app_instance && kube_namespace == $namespace && k8s.cluster.uid == $cluster\n| reduce max\n| group_by [service.name, k8s.app.instance, kube_namespace], sum\n"
      }
    }
    chart {
      name        = "HPA Current & Desired"
      description = "Number of current and desired replicas for horizontal pod autoscaling"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 0
      width       = 16
      height      = 6

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.hpa.current_replicas | filter (k8s.hpa.name =~ $service && k8s.namespace.name == $namespace && k8s.cluster.uid == $cluster) | latest 30s | group_by [\"k8s.hpa.name\", \"k8s.namespace.name\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.hpa.desired_replicas | filter (k8s.hpa.name =~ $service && k8s.namespace.name == $namespace && k8s.cluster.uid == $cluster) | latest 30s | group_by [\"k8s.hpa.name\", \"k8s.namespace.name\"], sum"
      }
    }
  }

  template_variable {
    name                     = "cluster"
    default_values           = []
    suggestion_attribute_key = "k8s.cluster.uid"
  }
  template_variable {
    name                     = "namespace"
    default_values           = []
    suggestion_attribute_key = "k8s.namespace.name"
  }
  template_variable {
    name                     = "kube_app_instance"
    default_values           = []
    suggestion_attribute_key = "k8s.app.instance"
  }
  template_variable {
    name                     = "service"
    default_values           = []
    suggestion_attribute_key = "service.name"
  }

  label {
    key   = ""
    value = "terraform"
  }
  label {
    key   = "type"
    value = "machine"
  }
}
