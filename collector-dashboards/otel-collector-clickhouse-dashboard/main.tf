terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.76.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_clickhouse_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "ClickHouse - Overview"
  dashboard_description = "The ClickHouse overview metrics dashboard provides real-time visibility into the health and performance of a ClickHouse cluster."

  chart {
    name = "Memory"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseMetrics_MemoryTracking | latest | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Inserted Rows"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "b"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_InsertedRows | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Delayed Inserts"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "b"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_DelayedInserts | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Inserted Bytes"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_InsertedBytes | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "SELECT Query Latencies"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a/b)"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric ClickHouseProfileEvents_SelectQueryTimeMicroseconds | rate 2m, 2m | group_by ["service.instance.id"], sum;
  b = metric ClickHouseProfileEvents_SelectQuery | rate 2m, 2m | group_by ["service.instance.id"], sum;
join ((a / b)), a=0, b=0 | reduce 2m, mean
EOT
    }

  }

  chart {
    name = "INSERT Query Latencies"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a/b)"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric ClickHouseProfileEvents_InsertQueryTimeMicroseconds | rate 2m, 2m | group_by ["service.instance.id"], sum;
  b = metric ClickHouseProfileEvents_InsertQuery | rate 2m, 2m | group_by ["service.instance.id"], sum;
join ((a / b)), a=0, b=0 | reduce 2m, mean
EOT
    }

  }

  chart {
    name = "Query Latencies"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a/b)"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric ClickHouseProfileEvents_QueryTimeMicroseconds | rate 2m, 2m | group_by ["service.instance.id"], sum;
  b = metric ClickHouseProfileEvents_Query | rate 2m, 2m | group_by ["service.instance.id"], sum;
join ((a / b)), a=0, b=0 | reduce 2m, mean
EOT
    }

  }

  chart {
    name = "Query Preemted"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseMetrics_QueryPreempted | latest | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Queries Memory Limit"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_QueryMemoryLimitExceeded | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Failed INSERT Queries"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_FailedInsertQuery | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Failed SELECT Queries"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_FailedSelectQuery | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Failed Queries"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_FailedQuery | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "INSERT Queries"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_InsertQuery | rate | group_by ["service.instance.id"], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_FailedInsertQuery | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "SELECT Queries"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_SelectQuery | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Slow Reads"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_SlowRead | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Read Backoff"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_ReadBackoff | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Connections"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseMetrics_TCPConnection | latest | group_by ["service.instance.id"], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseMetrics_HTTPConnection | latest | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Interserver"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseMetrics_InterserverConnection | latest | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Queries"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ClickHouseProfileEvents_Query | rate | group_by ["service.instance.id"], sum
EOT
    }

  }
}