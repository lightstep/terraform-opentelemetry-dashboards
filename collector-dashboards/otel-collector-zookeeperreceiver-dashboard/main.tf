terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_zookeeperreceiver_dashboard" {
  project_name          = var.cloud_observability_project
  dashboard_name        = "OpenTelemetry zookeeperreceiver Integration"
  dashboard_description = "Monitor Zookeeper with this overview dashboard."

  chart {
    name = "Active Connections"
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
    name = "Ephemeral Node Count"
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
    name = "Tree Size"
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
    name = "File Descriptor Limit"
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
    name = "File Descriptors Open"
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
    name = "Follower Count"
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
    name = "Fsync Exceeded Threshold Count"
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
    name = "Average Latency"
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
    name = "Max Latency"
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
    name = "Min Latency"
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
    name = "Packet Count"
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
    name = "Active Requests"
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
    name = "Pending Syncs"
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
    name = "Watch Count"
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
    name = "Znode Count"
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
