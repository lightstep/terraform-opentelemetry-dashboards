terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.86.1"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_sqlserverreceiver_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "sqlserverreceiver Integration"



  chart {
    name = "sqlserver.batch.request.rate"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.batch.request.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of batch requests received by SQL Server.
      # TODO: add unit: {requests}/s
    }
  }

  chart {
    name = "sqlserver.batch.sql_compilation.rate"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.batch.sql_compilation.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of SQL compilations needed.
      # TODO: add unit: {compilations}/s
    }
  }

  chart {
    name = "sqlserver.batch.sql_recompilation.rate"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.batch.sql_recompilation.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of SQL recompilations needed.
      # TODO: add unit: {compilations}/s
    }
  }

  chart {
    name = "sqlserver.lock.wait.rate"
    rank = "3"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.lock.wait.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of lock requests resulting in a wait.
      # TODO: add unit: {requests}/s
    }
  }

  chart {
    name = "sqlserver.lock.wait_time.avg"
    rank = "4"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.lock.wait_time.avg"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Average wait time for all lock requests that had to wait.
      # TODO: add unit: ms
    }
  }

  chart {
    name = "sqlserver.page.buffer_cache.hit_ratio"
    rank = "5"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.page.buffer_cache.hit_ratio"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Pages found in the buffer pool without having to read from disk.
      # TODO: add unit: %
    }
  }

  chart {
    name = "sqlserver.page.checkpoint.flush.rate"
    rank = "6"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.page.checkpoint.flush.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of pages flushed by operations requiring dirty pages to be flushed.
      # TODO: add unit: {pages}/s
    }
  }

  chart {
    name = "sqlserver.page.lazy_write.rate"
    rank = "7"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.page.lazy_write.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of lazy writes moving dirty pages to disk.
      # TODO: add unit: {writes}/s
    }
  }

  chart {
    name = "sqlserver.page.life_expectancy"
    rank = "8"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.page.life_expectancy"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Time a page will stay in the buffer pool.
      # TODO: add unit: s
    }
  }

  chart {
    name = "sqlserver.page.operation.rate"
    rank = "9"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.page.operation.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["page.operations"]
      }

      # TODO: add description: Number of physical database page operations issued.
      # TODO: add unit: {operations}/s
    }
  }

  chart {
    name = "sqlserver.page.split.rate"
    rank = "10"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.page.split.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of pages split as a result of overflowing index pages.
      # TODO: add unit: {pages}/s
    }
  }

  chart {
    name = "sqlserver.transaction.rate"
    rank = "11"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.transaction.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of transactions started for the database (not including XTP-only transactions).
      # TODO: add unit: {transactions}/s
    }
  }

  chart {
    name = "sqlserver.transaction.write.rate"
    rank = "12"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.transaction.write.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of transactions that wrote to the database and committed.
      # TODO: add unit: {transactions}/s
    }
  }

  chart {
    name = "sqlserver.transaction_log.flush.data.rate"
    rank = "13"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.transaction_log.flush.data.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Total number of log bytes flushed.
      # TODO: add unit: By/s
    }
  }

  chart {
    name = "sqlserver.transaction_log.flush.rate"
    rank = "14"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.transaction_log.flush.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of log flushes.
      # TODO: add unit: {flushes}/s
    }
  }

  chart {
    name = "sqlserver.transaction_log.flush.wait.rate"
    rank = "15"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.transaction_log.flush.wait.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of commits waiting for a transaction log flush.
      # TODO: add unit: {commits}/s
    }
  }

  chart {
    name = "sqlserver.transaction_log.growth.count"
    rank = "16"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.transaction_log.growth.count"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Total number of transaction log expansions for a database.
      # TODO: add unit: {growths}
    }
  }

  chart {
    name = "sqlserver.transaction_log.shrink.count"
    rank = "17"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.transaction_log.shrink.count"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Total number of transaction log shrinks for a database.
      # TODO: add unit: {shrinks}
    }
  }

  chart {
    name = "sqlserver.transaction_log.usage"
    rank = "18"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.transaction_log.usage"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Percent of transaction log space used.
      # TODO: add unit: %
    }
  }

  chart {
    name = "sqlserver.user.connection.count"
    rank = "19"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "sqlserver.user.connection.count"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of users connected to the SQL Server.
      # TODO: add unit: {connections}
    }
  }
}