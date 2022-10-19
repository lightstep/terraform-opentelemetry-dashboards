terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.6"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_iisreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry iisreceiver Integration"

    
    
    chart {
      name = "iis.connection.active"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.connection.active"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of active connections.
        # TODO: add unit: {connections}
      }
    }
    
    chart {
      name = "iis.connection.anonymous"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.connection.anonymous"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of connections established anonymously.
        # TODO: add unit: {connections}
      }
    }
    
    chart {
      name = "iis.connection.attempt.count"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.connection.attempt.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Total number of attempts to connect to the server.
        # TODO: add unit: {attempts}
      }
    }
    
    chart {
      name = "iis.network.blocked"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.network.blocked"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of bytes blocked due to bandwidth throttling.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "iis.network.file.count"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.network.file.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "direction"]
        }
        
        # TODO: add description: Number of transmitted files.
        # TODO: add unit: {files}
      }
    }
    
    chart {
      name = "iis.network.io"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.network.io"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "direction"]
        }
        
        # TODO: add description: Total amount of bytes sent and received.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "iis.request.count"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.request.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "request"]
        }
        
        # TODO: add description: Total number of requests of a given type.
        # TODO: add unit: {requests}
      }
    }
    
    chart {
      name = "iis.request.queue.age.max"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.request.queue.age.max"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Age of oldest request in the queue.
        # TODO: add unit: ms
      }
    }
    
    chart {
      name = "iis.request.queue.count"
      rank = "8"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.request.queue.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Current number of requests in the queue.
        # TODO: add unit: {requests}
      }
    }
    
    chart {
      name = "iis.request.rejected"
      rank = "9"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.request.rejected"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Total number of requests rejected.
        # TODO: add unit: {requests}
      }
    }
    
    chart {
      name = "iis.thread.active"
      rank = "10"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.thread.active"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Current number of active threads.
        # TODO: add unit: {threads}
      }
    }
    
    chart {
      name = "iis.uptime"
      rank = "11"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "iis.uptime"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The amount of time the server has been up.
        # TODO: add unit: s
      }
    }
}