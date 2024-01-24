terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.87.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_redis_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Redis"
  dashboard_description = "Monitor Redis with this overview dashboard."

  chart {
    name = "Hit Rate"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric redis.keyspace.hits | rate 1s | group_by [], sum;
  b = metric redis.keyspace.misses | rate 1s | group_by [], sum;
join ((a /(a + b))), a=0, b=0

EOT
    }

  }

  chart {
    name = "Unsaved Changes"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric redis.rdb.changes_since_last_save | reduce mean | group_by [], sum

EOT
    }

  }

  chart {
    name = "Commands"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric redis.commands | latest | group_by [], sum

EOT
    }

  }

  chart {
    name = "Cache Hit Rate"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric redis.keyspace.hits | rate 1s | group_by [], sum;
  b = metric redis.keyspace.misses | rate 1s | group_by [], sum;
join (((a /(a + b))*100)), a=0, b=0

EOT
    }

  }

  chart {
    name = "Percent Used Memory"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric redis.memory.used | latest | group_by ["host"], sum;
  b = metric redis.memory.peak | latest | group_by ["host"], sum;
join (((a / b)*100)), a=0, b=0

EOT
    }

  }

  chart {
    name = "Evictions"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric redis.keys.evicted | rate 1s | group_by ["host"], sum

EOT
    }

  }

  chart {
    name = "Blocked Clients"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric redis.clients.blocked | latest | group_by [], sum

EOT
    }

  }

  chart {
    name = "Fragmentation Ratio"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric redis.memory.fragmentation_ratio | latest | group_by [], mean

EOT
    }

  }

  chart {
    name = "Connected Clients"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric redis.clients.connected | latest | group_by [], sum

EOT
    }

  }

  chart {
    name = "Connected Replicas"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric redis.slaves.connected | latest | group_by [], sum

EOT
    }

  }

  chart {
    name = "Rejected Connections"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric redis.connections.rejected | delta | group_by [], sum

EOT
    }

  }

}
