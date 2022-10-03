terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.62.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_mongodbreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry mongodbreceiver Integration"

    
    
    chart {
      name = "mongodb.cache.operations"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.cache.operations"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "type"]
        }
        
        # TODO: add description: The number of cache operations of the instance.
        # TODO: add unit: {operations}
      }
    }
    
    chart {
      name = "mongodb.collection.count"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.collection.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database"]
        }
        
        # TODO: add description: The number of collections.
        # TODO: add unit: {collections}
      }
    }
    
    chart {
      name = "mongodb.connection.count"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.connection.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database", "connection_type"]
        }
        
        # TODO: add description: The number of connections.
        # TODO: add unit: {connections}
      }
    }
    
    chart {
      name = "mongodb.data.size"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.data.size"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database"]
        }
        
        # TODO: add description: The size of the collection. Data compression does not affect this value.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "mongodb.extent.count"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.extent.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database"]
        }
        
        # TODO: add description: The number of extents.
        # TODO: add unit: {extents}
      }
    }
    
    chart {
      name = "mongodb.global_lock.time"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.global_lock.time"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The time the global lock has been held.
        # TODO: add unit: ms
      }
    }
    
    chart {
      name = "mongodb.index.count"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.index.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database"]
        }
        
        # TODO: add description: The number of indexes.
        # TODO: add unit: {indexes}
      }
    }
    
    chart {
      name = "mongodb.index.size"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.index.size"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database"]
        }
        
        # TODO: add description: Sum of the space allocated to all indexes in the database, including free index space.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "mongodb.memory.usage"
      rank = "8"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.memory.usage"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database", "memory_type"]
        }
        
        # TODO: add description: The amount of memory used.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "mongodb.object.count"
      rank = "9"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.object.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database"]
        }
        
        # TODO: add description: The number of objects.
        # TODO: add unit: {objects}
      }
    }
    
    chart {
      name = "mongodb.operation.count"
      rank = "10"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.operation.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "operation"]
        }
        
        # TODO: add description: The number of operations executed.
        # TODO: add unit: {operations}
      }
    }
    
    chart {
      name = "mongodb.storage.size"
      rank = "11"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mongodb.storage.size"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database"]
        }
        
        # TODO: add description: The total amount of storage allocated to this collection.
        # TODO: add unit: By
      }
    }
}