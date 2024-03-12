terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.93.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_cilium_overview_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Cilium Overview"
  dashboard_description = "Monitor Cilium with this metrics overview dashboard."

  chart {
    name = "Cilium Endpoints"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric cilium_endpoint | latest | group_by [], sum"
    }

  }

  chart {
    name = "Endpoints by State"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric cilium_endpoint_state | latest | group_by ["endpoint_state"], sum
EOT
    }

  }

  chart {
    name = "Endpoint Regenerations by Outcome"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric cilium_endpoint_regenerations_total | delta | group_by ["outcome"], sum
EOT
    }

  }

  chart {
    name = "Endpoint Regeneration Time (percentiles)"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric cilium_endpoint_regeneration_time_stats_seconds | delta 2m | group_by [], sum | point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)"
    }

  }

  chart {
    name = "Egress Packets Dropped by Reason"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cilium_drop_count_total | filter (direction == "EGRESS") | rate | group_by ["reason"], sum
EOT
    }
  }

  chart {
    name = "Ingress Packets Dropped by Reason"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cilium_drop_count_total | filter (direction == "INGRESS") | rate | group_by ["reason"], sum
EOT
    }
  }

  chart {
    name = "Ingress Packets Forwarded"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cilium_forward_count_total | filter (direction == "INGRESS") | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Egress Packets Forwarded"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cilium_forward_count_total | filter (direction == "EGRESS") | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Policy Count"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric cilium_policy | latest | group_by [], sum"
    }

  }

  chart {
    name = "Policy Import Errors"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric cilium_policy_import_errors_total | delta | group_by [], sum"
    }

  }

  chart {
    name = "Endpoint Enforcement Status"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric cilium_policy_endpoint_enforcement_status | latest | group_by [], sum"
    }

  }

  chart {
    name = "Policy Regeneration Time (percentiles)"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric cilium_policy_regeneration_time_stats_seconds | delta | group_by [], sum | point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)"
    }

  }

  chart {
    name = "IPAM Events by Action"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cilium_ipam_events_total | rate | group_by ["action"], sum
EOT
    }

  }

  chart {
    name = "Identities Allocated"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric cilium_identity | latest | group_by [], sum"
    }

  }

  chart {
    name = "Agent CPU Usage by Host"
    rank = "14"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cilium_process_cpu_seconds_total | delta | group_by ["net.host.name"], sum
EOT
    }

  }

  chart {
    name = "Operator Process CPU Seconds"
    rank = "15"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric cilium_process_cpu_seconds_total | delta | group_by [], sum"
    }

  }

  chart {
    name = "Agent Process Memory"
    rank = "16"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric cilium_process_resident_memory_bytes | latest | group_by [], sum"
    }

  }

  chart {
    name = "Operator Process Memory"
    rank = "17"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric cilium_operator_process_resident_memory_bytes | latest | group_by [], sum"
    }

  }

  chart {
    name = "K8S API Calls/Minute by Host"
    rank = "18"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cilium_k8s_client_api_calls_total | rate 1m | group_by ["host"], sum
EOT
    }

  }

  chart {
    name = "K8S API Call Latency by Host (percentiles)"
    rank = "19"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cilium_k8s_client_api_latency_time_seconds | delta | group_by ["net.host.name"], sum | point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)
EOT
    }

  }

  chart {
    name = "Unreachable Node Count by Host"
    rank = "20"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric cilium_unreachable_nodes | latest | top [host.name], 10, mean, 10m"
    }

  }
}

