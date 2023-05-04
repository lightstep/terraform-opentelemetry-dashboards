terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.76.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_cassandrareceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Cassandra"
  dashboard_description = "Monitor Cassandra performance and health with this overview dashboard."

  chart {
    name = "Read Requests"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.storage.read_request | delta | group_by [service.name], sum
EOT
    }
  }

  chart {
    name = "Write Requests"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.storage.write_request | delta | group_by [service.name], sum
EOT
    }
  }

  chart {
    name = "Read Latency"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.storage.read_latency | group_by [service.name], mean
EOT
    }
  }

  chart {
    name = "Write Latency"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.storage.write_latency | group_by [service.name], mean
EOT
    }
  }

  chart {
    name = "Pending Read Requests"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.storage.pending_read_request | group_by [service.name], sum
EOT
    }
  }

  chart {
    name = "Pending Write Requests"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.storage.pending_write_request | group_by [service.name], sum
EOT
    }
  }

  chart {
    name = "Disk Space Used"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.storage.disk_space_used | group_by [service.name], sum
EOT
    }
  }

  chart {
    name = "Compaction Tasks"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.compaction.compaction_tasks | group_by [service.name], sum
EOT
    }
  }

  chart {
    name = "Cache Hit Rate"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.cache.hit_rate | group_by [service.name], mean
EOT
    }
  }

  chart {
    name = "Garbage Collection Count"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.gc.collection_count | delta | group_by [service.name], sum
EOT
    }
  }

  chart {
    name = "Garbage Collection Time"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.gc.collection_time | delta | group_by [service.name], sum
EOT
    }
  }

  chart {
    name = "Heap Memory Usage"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric cassandra.memory.heap_usage | group_by [service.name], mean
EOT
    }
  }
}

