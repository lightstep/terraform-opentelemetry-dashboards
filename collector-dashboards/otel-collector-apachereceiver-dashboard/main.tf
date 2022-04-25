terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.60.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_apachereceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry apachereceiver Integration"

    
    
    chart {
      name = "apache.current_connections"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "apache.current_connections"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = [ "server_name"]
        }
        
        # TODO: add description: The number of active connections currently attached to the HTTP server.
        # TODO: add unit: connections
      }
    }
    
    chart {
      name = "apache.requests"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "apache.requests"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = [ "server_name"]
        }
        
        # TODO: add description: The number of requests serviced by the HTTP server per second.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "apache.scoreboard"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "apache.scoreboard"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = [ "server_name", "scoreboard_state"]
        }
        
        # TODO: add description: The number of connections in each state.
        # TODO: add unit: scoreboard
      }
    }
    
    chart {
      name = "apache.traffic"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "apache.traffic"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = [ "server_name"]
        }
        
        # TODO: add description: Total HTTP server traffic.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "apache.uptime"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "apache.uptime"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = [ "server_name"]
        }
        
        # TODO: add description: The amount of time that the server has been running in seconds.
        # TODO: add unit: s
      }
    }
    
    chart {
      name = "apache.workers"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "apache.workers"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = [ "server_name", "workers_state"]
        }
        
        # TODO: add description: The number of workers currently attached to the HTTP server.
        # TODO: add unit: connections
      }
    }
}