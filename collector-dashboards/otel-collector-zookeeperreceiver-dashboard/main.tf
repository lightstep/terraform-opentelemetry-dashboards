terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_zookeeperreceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry zookeeperreceiver Integration"
  dashboard_description = "Monitor Zookeeper with this overview dashboard."

  chart {
    name = "zookeeper.connection.active"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.connection.active | rate | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.data_tree.ephemeral_node.count"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.data_tree.ephemeral_node.count | rate | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.data_tree.size"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.data_tree.size | rate | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.file_descriptor.limit"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.file_descriptor.limit | latest | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.file_descriptor.open"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.file_descriptor.open | rate | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.follower.count"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric zookeeper.follower.count | rate | group_by ["state"], sum
EOT
    }

  }

  chart {
    name = "zookeeper.fsync.exceeded_threshold.count"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.fsync.exceeded_threshold.count | rate | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.latency.avg"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.latency.avg | latest | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.latency.max"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.latency.max | latest | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.latency.min"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.latency.min | latest | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.packet.count"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric zookeeper.packet.count | rate | group_by ["direction"], sum
EOT
    }

  }

  chart {
    name = "zookeeper.request.active"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.request.active | rate | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.sync.pending"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.sync.pending | rate | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.watch.count"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.watch.count | rate | group_by [], sum"
    }

  }

  chart {
    name = "zookeeper.znode.count"
    rank = "14"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric zookeeper.znode.count | rate | group_by [], sum"
    }

  }

}
