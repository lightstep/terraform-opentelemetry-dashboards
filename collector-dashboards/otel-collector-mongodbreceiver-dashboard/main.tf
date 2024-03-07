terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.92.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_mongodb_summary_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "MongoDB Summary"
  dashboard_description = "Monitor MongoDB metrics with the OTel Collector's MongoDB receiver."

  chart {
    name = "Operations (per minute)"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mongodb.operation.count | rate 1m | group_by ["operation"], sum
EOT
    }

  }

  chart {
    name = "Cache Operations (per minute)"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mongodb.cache.operations | rate 1m | group_by ["type"], sum
EOT
    }

  }

  chart {
    name = "Index Accesses (per minute)"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mongodb.index.access.count | rate 1m | group_by ["database"], sum
EOT
    }

  }

  chart {
    name = "Memory Usage"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mongodb.memory.usage | latest | group_by ["database", "memory_type"], sum
EOT
    }

  }

  chart {
    name = "Object Count"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mongodb.object.count | delta | group_by ["database"], sum
EOT
    }

  }

  chart {
    name = "Collection Count"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mongodb.collection.count | latest | group_by ["database"], sum
EOT
    }

  }

  chart {
    name = "Index Count"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mongodb.index.count | rate | group_by ["database"], sum
EOT
    }

  }

  chart {
    name = "Index Size"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mongodb.index.size | latest | group_by ["database"], sum
EOT
    }

  }

  chart {
    name = "Network (TX/RX)"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric mongodb.network.io.receive | delta | group_by [], sum"
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = "metric mongodb.network.io.transmit | delta | group_by [], sum"
    }

  }

  chart {
    name = "Connection Count"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mongodb.connection.count | rate | group_by ["database", "connection_type"], sum
EOT
    }

  }

  chart {
    name = "Data Size"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mongodb.data.size | latest | group_by ["database"], sum
EOT
    }

  }

  chart {
    name = "Storage Size"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric mongodb.storage.size | delta | group_by ["database"], sum
EOT
    }

  }

  chart {
    name = "Global Lock Time"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric mongodb.global_lock.time | rate | group_by [], sum"
    }

  }

}
