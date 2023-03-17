terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_operator_dashboard_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry Operator"
  dashboard_description = "Monitor your OpenTelemetry operator with this overview dashboard."

  chart {
    name = "Total reconciles"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric controller_runtime_reconcile_total | delta | group_by ["controller", "result", "pod"], sum
EOT
    }

  }

  chart {
    name = "Time to reconcile"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "heatmap"
      hidden       = false
      query_string = <<EOT
metric controller_runtime_reconcile_time_seconds | delta | group_by ["controller"], sum
EOT
    }

  }

  chart {
    name = "Reconcile Errors"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric controller_runtime_reconcile_errors_total | delta | group_by ["controller"], max
EOT
    }

  }

  chart {
    name = "CPU Usage"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container_cpu_usage_seconds_total | rate | group_by ["pod"], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_requests | latest | group_by ["pod"], sum
EOT
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_limits | latest | group_by ["pod"], sum
EOT
    }

  }

  chart {
    name = "Memory Usage"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container_memory_working_set_bytes | latest | group_by ["pod"], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_requests | latest | group_by ["pod"], sum
EOT
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_resource_limits | latest | group_by ["pod"], sum
EOT
    }

  }

  chart {
    name = "Restarts in the past 30 mins"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric kube_pod_container_status_restarts_total | rate | group_by ["pod"], sum
EOT
    }

  }

}
