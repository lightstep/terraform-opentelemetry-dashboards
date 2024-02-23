terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.4"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_memcachedreceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "memcachedreceiver Integration"
  dashboard_description = "Monitor Memcached performance with this overview dashboard."

  chart {
    name = "Bytes"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric memcached.bytes | latest | group_by [], sum"
    }

  }

  chart {
    name = "Commands"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric memcached.commands | rate | group_by ["command"], sum
EOT
    }

  }

  chart {
    name = "Connections - Current"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric memcached.connections.current | rate | group_by [], sum"
    }

  }

  chart {
    name = "Connections - Total"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric memcached.connections.total | rate | group_by [], sum"
    }

  }

  chart {
    name = "CPU Usage (by State)"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric memcached.cpu.usage | rate | group_by ["state"], sum
EOT
    }

  }

  chart {
    name = "Current Items"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric memcached.current_items | rate | group_by [], sum"
    }

  }

  chart {
    name = "Evictions"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric memcached.evictions | rate | group_by [], sum"
    }

  }

  chart {
    name = "Throughput (by Direction)"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric memcached.network | rate | group_by ["direction"], sum
EOT
    }

  }

  chart {
    name = "Hit Ratio (by Operation)"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric memcached.operation_hit_ratio | latest | group_by ["operation"], sum
EOT
    }

  }

  chart {
    name = "Operations (by Type)"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric memcached.operations | rate | group_by ["type", "operation"], sum
EOT
    }

  }

  chart {
    name = "Threads "
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric memcached.threads | rate | group_by [], sum"
    }

  }

}
