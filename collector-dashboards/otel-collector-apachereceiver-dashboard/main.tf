terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.84.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_apachereceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry / Apache Integration"
  dashboard_description = "Monitor Apache HTTP Server with this dashboard."

  chart {
    name = "Requests"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric apache.requests | rate | group_by ["server_name"], sum
EOT
    }

  }

  chart {
    name = "Bytes"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric apache.traffic | rate | group_by ["server_name"], sum
EOT
    }

  }

  chart {
    name = "Workers"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric apache.workers | latest | group_by ["server_name", "state"], sum
EOT
    }

  }

  chart {
    name = "Connections"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric apache.current_connections | latest | group_by ["server_name"], sum
EOT
    }

  }

  chart {
    name = "Scoreboard"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric apache.scoreboard | latest | group_by ["server_name", "state"], sum
EOT
    }

  }

  /*
  // TODO: create big_number display
  chart {
    name = "Up"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric apache.uptime | latest | group_by ["server_name"], sum
EOT
    }
  }
  */

}
