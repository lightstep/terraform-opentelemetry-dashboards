terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.76.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_nginxreceiver_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "OpenTelemetry nginxreceiver Integration"

  chart {
    name = "Nginx Connections Accepted"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display_type = "line"
      hidden       = false
      query_string = <<EOT
metric nginx.connections_accepted | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Nginx Connections Current"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display_type = "line"
      hidden       = false
      query_string = <<EOT
metric nginx.connections_current | last | group_by ["state"], sum
EOT
    }
  }

  chart {
    name = "Nginx Connections Handled"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display_type = "line"
      hidden       = false
      query_string = <<EOT
metric nginx.connections_handled | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Nginx Requests"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display_type = "line"
      hidden       = false
      query_string = <<EOT
metric nginx.requests | rate | group_by [], sum
EOT
    }
  }
}
