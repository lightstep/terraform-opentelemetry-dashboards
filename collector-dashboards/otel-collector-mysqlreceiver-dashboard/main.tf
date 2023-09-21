terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_mysql_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "MySQL"
  dashboard_description = "Monitor MySQL performance with this overview dashboard."

  chart {
    name = "Row Operations"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.row_operations | rate | group_by ["operation"], sum

EOT
    }

  }

  chart {
    name = "Sorts"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.sorts | rate | group_by ["kind"], sum

EOT
    }

  }

  chart {
    name = "Buffer Pool Utilization (Usage / Limit)"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.buffer_pool.usage | latest | group_by ["status"], sum

EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = "metric mysql.buffer_pool.limit | latest | group_by [], sum"
    }

  }

  chart {
    name = "Buffer Pool Operations"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.buffer_pool.operations | rate | group_by ["operation"], sum

EOT
    }

  }

  chart {
    name = "Connections"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric mysql.threads | filter (kind == "connected") | latest | group_by [], sum

EOT
    }

  }

  chart {
    name = "Locked Connects"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric mysql.locked_connects | rate | group_by [], sum"
    }

  }

  chart {
    name = "Slow Queries"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric mysql.query.slow.count | rate | group_by [], sum"
    }

  }

  chart {
    name = "Database Locks"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric mysql.locks | rate | group_by [], sum"
    }

  }

  chart {
    name = "Row Locks"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric mysql.row_locks | rate | group_by [], sum"
    }

  }

  chart {
    name = "Buffer Pool Pages"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.buffer_pool.pages | latest | group_by ["kind"], sum

EOT
    }

  }

  chart {
    name = "Page Flushes"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric mysql.buffer_pool.page_flushes | rate | group_by [], sum"
    }

  }

  chart {
    name = "Logs"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.log_operations | rate | group_by ["operation"], sum

EOT
    }

  }

  chart {
    name = "Data Pages"
    rank = "14"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.buffer_pool.data_pages | latest | group_by ["status"], sum

EOT
    }

  }

  chart {
    name = "Handlers"
    rank = "15"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.handlers | rate | group_by ["kind"], sum

EOT
    }

  }

  chart {
    name = "Threads"
    rank = "16"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.threads | latest | group_by ["kind"], sum

EOT
    }

  }

  chart {
    name = "Opened Resources"
    rank = "17"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.opened_resources | rate | group_by ["kind"], sum

EOT
    }

  }

  chart {
    name = "Temporary Resources"
    rank = "18"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.tmp_resources | rate | group_by ["resource"], sum

EOT
    }

  }

  chart {
    name = "Double Writes"
    rank = "19"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mysql.double_writes | rate | group_by ["kind"], sum

EOT
    }

  }

}
