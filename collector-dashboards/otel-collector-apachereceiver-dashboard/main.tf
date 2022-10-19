terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.6"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_apachereceiver_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "OpenTelemetry / Apache Integration"

  chart {
    name = "Requests"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "apache.requests"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["server_name"]
      }

      # TODO: add description: The number of requests serviced by the HTTP server per second.
      # TODO: add unit: 1
    }
  }

  chart {
    name = "Bytes"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "apache.traffic"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["server_name"]
      }

      # TODO: add description: Total HTTP server traffic.
      # TODO: add unit: By
    }
  }

  chart {
    name = "Workers"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "apache.workers"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["server_name", "state"]
      }

      # TODO: add description: The number of workers currently attached to the HTTP server.
      # TODO: add unit: connections
    }
  }

  chart {
    name = "Connections"
    rank = "3"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "apache.current_connections"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["server_name"]
      }

      # TODO: add description: The number of active connections currently attached to the HTTP server.
      # TODO: add unit: connections
    }
  }

  chart {
    name = "Scoreboard"
    rank = "4"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "area"
      hidden     = false

      metric              = "apache.scoreboard"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["server_name", "state"]
      }

      # TODO: add description: The number of connections in each state.
      # TODO: add unit: scoreboard
    }
  }

  chart {
    name = "Up"
    rank = "5"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "bar"
      hidden     = false

      metric              = "apache.uptime"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["server_name"]
      }

      # TODO: add description: The amount of time that the server has been running in seconds.
      # TODO: add unit: s
    }
  }
}
