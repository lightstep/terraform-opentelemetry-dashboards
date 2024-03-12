terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.93.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_kubeletstatsreceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Kubeletstats Receiver"
  dashboard_description = "Monitor Kubeletstats with this metrics overview dashboard."

  chart {
    name = "Container CPU Time"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric container.cpu.time | rate | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "Container CPU Utilization"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric container.cpu.utilization | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "Container Filesystem Available"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric container.filesystem.available | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "Container Filesystem Capacity"
    rank = "3"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric container.filesystem.capacity | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "Container Filesystem Usage"
    rank = "4"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric container.filesystem.usage | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "Container Memory Available"
    rank = "5"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric container.memory.available | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "Container Memory Major Page Faults"
    rank = "6"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric container.memory.major_page_faults | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "Container Memory Page Faults"
    rank = "7"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric container.memory.page_faults | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "Container Memory RSS"
    rank = "8"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric container.memory.rss | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "Container Memory Usage"
    rank = "9"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric container.memory.usage | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "Container Memory Working Set"
    rank = "10"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric container.memory.working_set | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "K8S Pod Network Errors"
    rank = "11"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric k8s.pod.network.errors | rate | group_by ["interface", "direction"], sum
EOT

    }
  }

  chart {
    name = "K8S Pod Network IO"
    rank = "12"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric k8s.pod.network.io | rate | group_by ["interface", "direction"], sum
EOT

    }
  }

  chart {
    name = "K8S Volume Available"
    rank = "13"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric k8s.volume.available | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "K8S Volume Capacity"
    rank = "14"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric k8s.volume.capacity | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "K8S Volume Inodes"
    rank = "15"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric k8s.volume.inodes | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "K8S Volume Inodes Free"
    rank = "16"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric k8s.volume.inodes.free | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }

  chart {
    name = "K8S Volume Inodes Used"
    rank = "17"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      query_string = <<EOT
metric k8s.volume.inodes.used | latest | group_by ["k8s.pod.name", "k8s.namespace.name"], sum
EOT

    }
  }
}
