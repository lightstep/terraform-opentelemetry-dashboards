terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_postgresqlreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry postgresqlreceiver Integration"

    
    
    chart {
      name = "postgresql.backends"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "postgresql.backends"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database"]
        }
        
        # TODO: add description: The number of backends.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "postgresql.blocks_read"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "postgresql.blocks_read"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database", "table", "source"]
        }
        
        # TODO: add description: The number of blocks read.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "postgresql.commits"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "postgresql.commits"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database"]
        }
        
        # TODO: add description: The number of commits.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "postgresql.db_size"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "postgresql.db_size"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database"]
        }
        
        # TODO: add description: The database disk usage.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "postgresql.operations"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "postgresql.operations"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database", "table", "operation"]
        }
        
        # TODO: add description: The number of db row operations.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "postgresql.rollbacks"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "postgresql.rollbacks"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database"]
        }
        
        # TODO: add description: The number of rollbacks.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "postgresql.rows"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "postgresql.rows"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "database", "table", "state"]
        }
        
        # TODO: add description: The number of rows in the database.
        # TODO: add unit: 1
      }
    }
}