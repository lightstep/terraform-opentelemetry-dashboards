terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_hikaricp_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry HikariCP Dashboard"
  dashboard_description = "Monitor HikariCP with this connection pool metrics summary."

  chart {
    name = "Active Connections"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_active_connections | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Idle Connections"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_idle_connections | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Pending Threads"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_pending_threads | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Min Connections"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_min_connections | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Max Connections"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_max_connections | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Connection Timeout Total"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_connection_timeout_total | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Connection Usage Millis Sum"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_connection_usage_millis_sum | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Connection Creation Millis Sum"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_connection_creation_millis_sum | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Connection Acquired Nanos Sum"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_connection_acquired_nanos_sum | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Connection Usage Millis Bucket"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_connection_usage_millis_bucket | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Connection Creation Millis Bucket"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_connection_creation_millis_bucket | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Connection Acquired Nanos Bucket"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric hikaricp_connection_acquired_nanos_bucket | rate | group_by [], sum
EOT
    }
  }
}
