terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.86.1"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_snmp_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "SNMP Metrics"
  dashboard_description = "Monitor SNMP with this metrics overview dashboard."

  chart {
    name = "CPU Idle"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric snmp_cpu_idle | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "CPU User"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric snmp_cpu_user | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "CPU System"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric snmp_cpu_system | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Memory Total Swap"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric snmp_memory_total_swap | delta | group_by [], sum
EOT
    }
  }
}

