terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_mysqlreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry mysqlreceiver Integration"

    
    
    chart {
      name = "mysql.buffer_pool.data_pages"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.buffer_pool.data_pages"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "buffer_pool_data"]
        }
        
        # TODO: add description: The number of data pages in the InnoDB buffer pool.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.buffer_pool.limit"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.buffer_pool.limit"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The configured size of the InnoDB buffer pool.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "mysql.buffer_pool.operations"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.buffer_pool.operations"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "buffer_pool_operations"]
        }
        
        # TODO: add description: The number of operations on the InnoDB buffer pool.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.buffer_pool.page_flushes"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.buffer_pool.page_flushes"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of requests to flush pages from the InnoDB buffer pool.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.buffer_pool.pages"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.buffer_pool.pages"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "buffer_pool_pages"]
        }
        
        # TODO: add description: The number of pages in the InnoDB buffer pool.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.buffer_pool.usage"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.buffer_pool.usage"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "buffer_pool_data"]
        }
        
        # TODO: add description: The number of bytes in the InnoDB buffer pool.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "mysql.commands"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.commands"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "command"]
        }
        
        # TODO: add description: The number of times each type of command has been executed.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.double_writes"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.double_writes"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "double_writes"]
        }
        
        # TODO: add description: The number of writes to the InnoDB doublewrite buffer.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.handlers"
      rank = "8"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.handlers"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "handler"]
        }
        
        # TODO: add description: The number of requests to various MySQL handlers.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.locks"
      rank = "9"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.locks"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "locks"]
        }
        
        # TODO: add description: The number of MySQL locks.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.log_operations"
      rank = "10"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.log_operations"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "log_operations"]
        }
        
        # TODO: add description: The number of InnoDB log operations.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.operations"
      rank = "11"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.operations"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "operations"]
        }
        
        # TODO: add description: The number of InnoDB operations.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.page_operations"
      rank = "12"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.page_operations"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "page_operations"]
        }
        
        # TODO: add description: The number of InnoDB page operations.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.row_locks"
      rank = "13"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.row_locks"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "row_locks"]
        }
        
        # TODO: add description: The number of InnoDB row locks.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.row_operations"
      rank = "14"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.row_operations"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "row_operations"]
        }
        
        # TODO: add description: The number of InnoDB row operations.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.sorts"
      rank = "15"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.sorts"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "sorts"]
        }
        
        # TODO: add description: The number of MySQL sorts.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "mysql.threads"
      rank = "16"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "mysql.threads"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "threads"]
        }
        
        # TODO: add description: The state of MySQL threads.
        # TODO: add unit: 1
      }
    }
}