terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_dockerstats_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "Dockerstats Metrics"
  dashboard_description = "Monitor Docker with this metrics overview dashboard."

  chart {
    name = "Percentage of CPU Used"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container.cpu.percent | delta | group_by ["container.id"], sum
EOT
    }
  }

  chart {
    name = "Percentage of Memory Used"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container.memory.percent | delta | group_by ["container.id"], sum
EOT
    }
  }

  chart {
    name = "Memory Usage"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container.memory.usage.total | latest | group_by ["container.id"], sum
EOT
    }
  }

  chart {
    name = "Memory Limit"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container.memory.usage.limit | delta | group_by ["container.id"], sum
EOT
    }
  }

  chart {
    name = "Bytes Received"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container.network.io.usage.rx_bytes | delta | group_by ["container.id"], sum
EOT
    }
  }

  chart {
    name = "Incoming Packets Dropped"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container.network.io.usage.rx_dropped | delta | group_by ["container.id"], sum
EOT
    }
  }

  chart {
    name = "Bytes Sent"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container.network.io.usage.tx_bytes | delta | group_by ["container.id"], sum
EOT
    }
  }

  chart {
    name = "Outgoing Packets Dropped"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container.network.io.usage.tx_dropped | delta | group_by ["container.id"], sum
EOT
    }
  }

  chart {
    name = "Bytes Transferred"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric container.blockio.io_service_bytes_recursive | delta | group_by ["container.id"], sum
EOT
    }
  }
}

