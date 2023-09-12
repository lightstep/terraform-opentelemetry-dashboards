terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_teamcity_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry Team City Dashboard"
  dashboard_description = "Monitor Team City with this CI/CD metrics summary."

  chart {
    name = "Connected Authorized Agents"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric agents_connected_authorized_number | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Build Queue Length"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric build_queue_length | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Running Builds Count"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric running_builds_count | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "VCS Problem Count"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "d"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric vcs_problem_count | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Server CPU Usage"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "e"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric server_cpu_usage | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Connected Unauthorized Agents"
    rank = "5"
    type = "timeseries"
    query {
      query_name   = "f"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric agents_connected_unauthorized_number | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Disconnected Agents"
    rank = "6"
    type = "timeseries"
    query {
      query_name   = "g"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric agents_disconnected_number | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "VCS Polling Time"
    rank = "7"
    type = "timeseries"
    query {
      query_name   = "h"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric vcs_polling_time | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Server Memory Usage"
    rank = "8"
    type = "timeseries"
    query {
      query_name   = "i"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric server_memory_usage | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Database Connection Count"
    rank = "9"
    type = "timeseries"
    query {
      query_name   = "j"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric db_connection_count | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Database Query Time"
    rank = "10"
    type = "timeseries"
    query {
      query_name   = "k"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric db_query_time | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Artifact Size"
    rank = "11"
    type = "timeseries"
    query {
      query_name   = "l"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric artifacts_size | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Server Uptime"
    rank = "12"
    type = "timeseries"
    query {
      query_name   = "m"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric server_uptime | rate | group_by [], sum
EOT
    }
  }
}
