terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.62.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_memcachedreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry memcachedreceiver Integration"

    
    
    chart {
      name = "memcached.bytes"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memcached.bytes"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Current number of bytes used by this server to store items.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "memcached.commands"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memcached.commands"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "command"]
        }
        
        # TODO: add description: Commands executed.
        # TODO: add unit: {commands}
      }
    }
    
    chart {
      name = "memcached.connections.current"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memcached.connections.current"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The current number of open connections.
        # TODO: add unit: {connections}
      }
    }
    
    chart {
      name = "memcached.connections.total"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memcached.connections.total"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Total number of connections opened since the server started running.
        # TODO: add unit: {connections}
      }
    }
    
    chart {
      name = "memcached.cpu.usage"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memcached.cpu.usage"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "state"]
        }
        
        # TODO: add description: Accumulated user and system time.
        # TODO: add unit: s
      }
    }
    
    chart {
      name = "memcached.current_items"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memcached.current_items"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of items currently stored in the cache.
        # TODO: add unit: {items}
      }
    }
    
    chart {
      name = "memcached.evictions"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memcached.evictions"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Cache item evictions.
        # TODO: add unit: {evictions}
      }
    }
    
    chart {
      name = "memcached.network"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memcached.network"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "direction"]
        }
        
        # TODO: add description: Bytes transferred over the network.
        # TODO: add unit: by
      }
    }
    
    chart {
      name = "memcached.operation_hit_ratio"
      rank = "8"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memcached.operation_hit_ratio"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = [ "operation"]
        }
        
        # TODO: add description: Hit ratio for operations, expressed as a percentage value between 0.0 and 100.0.
        # TODO: add unit: %
      }
    }
    
    chart {
      name = "memcached.operations"
      rank = "9"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memcached.operations"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "type", "operation"]
        }
        
        # TODO: add description: Operation counts.
        # TODO: add unit: {operations}
      }
    }
    
    chart {
      name = "memcached.threads"
      rank = "10"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memcached.threads"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of threads used by the memcached instance.
        # TODO: add unit: {threads}
      }
    }
}