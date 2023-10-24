terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.84.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "k8s_resources_pod_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Kubernetes Resources - Pods (Prometheus)"
  dashboard_description = "Monitor K8S Pod Resources with this overview dashboard where charts are powered by Prometheus format metrics exposed by the [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics) agent."

  chart {
    name = "Pods Containers Running"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_status_running | filter ((service.name == $service_name) && (net.host.name == $net_host_name) && (pod == $pod) && (container == $container)) | delta | group_by [], mean
EOT
    }

  }

  chart {
    name = "CPU Usage - Limits/Requests"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_requests | filter ((service.name == $service_name) && (net.host.name == $net_host_name) && (pod == $pod) && (container == $container)) | latest | group_by [], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_limits | filter ((service.name == $service_name) && (net.host.name == $net_host_name) && (pod == $pod) && (container == $container)) | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Memory Usage (WSS) - Limits/Requests"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_requests | filter ((service.name == $service_name) && (net.host.name == $net_host_name) && (pod == $pod) && (container == $container)) | latest | group_by [], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_limits | filter ((service.name == $service_name) && (net.host.name == $net_host_name) && (pod == $pod) && (container == $container)) | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Restarts Containers Total"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_status_restarts_total | filter ((service.name == $service_name) && (net.host.name == $net_host_name) && (pod == $pod) && (container == $container)) | delta | group_by [], sum
EOT
    }

  }

  chart {
    name = "Pod Start Time"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_start_time | filter ((service.name == $service_name) && (net.host.name == $net_host_name) && (pod == $pod)) | delta | group_by [], sum
EOT
    }

  }

  chart {
    name = "Pod Completiion Time"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric kube_pod_completion_time | filter ((service.name == $service_name) && (net.host.name == $net_host_name) && (pod == $pod)) | delta | group_by [], sum
EOT
    }

  }

  chart {
    name = "Pods containers waiting"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_status_waiting | filter ((service.name == $service_name) && (net.host.name == $net_host_name) && (pod == $pod) && (container == $container)) | delta | group_by ["pod"], sum
EOT
    }

  }

  chart {
    name = "Pods created"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_created | filter ((service.name == $service_name) && (net.host.name == $net_host_name) && (pod == $pod)) | delta | group_by [], sum
EOT
    }

  }

  chart {
    name = "Pods unschedulable "
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_status_unschedulable | filter ((service.name == $service_name) && (net.host.name == $net_host_name) && (pod == $pod)) | delta | group_by [], sum
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
  template_variable {
    name                     = "pod"
    default_values           = []
    suggestion_attribute_key = "pod"
  }
  template_variable {
    name                     = "container"
    default_values           = []
    suggestion_attribute_key = "container"
  }

  label {
    key   = ""
    value = "prometheus"
  }
}
