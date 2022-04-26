terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.60.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_zookeeperreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry zookeeperreceiver Integration"

    
    
    chart {
      name = "zookeeper.connection.active"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.connection.active"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of active clients connected to a ZooKeeper server.
        # TODO: add unit: {connections}
      }
    }
    
    chart {
      name = "zookeeper.data_tree.ephemeral_node.count"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.data_tree.ephemeral_node.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of ephemeral nodes that a ZooKeeper server has in its data tree.
        # TODO: add unit: {nodes}
      }
    }
    
    chart {
      name = "zookeeper.data_tree.size"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.data_tree.size"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Size of data in bytes that a ZooKeeper server has in its data tree.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "zookeeper.file_descriptor.limit"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.file_descriptor.limit"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Maximum number of file descriptors that a ZooKeeper server can open.
        # TODO: add unit: {file_descriptors}
      }
    }
    
    chart {
      name = "zookeeper.file_descriptor.open"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.file_descriptor.open"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of file descriptors that a ZooKeeper server has open.
        # TODO: add unit: {file_descriptors}
      }
    }
    
    chart {
      name = "zookeeper.follower.count"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.follower.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "state"]
        }
        
        # TODO: add description: The number of followers. Only exposed by the leader.
        # TODO: add unit: {followers}
      }
    }
    
    chart {
      name = "zookeeper.fsync.exceeded_threshold.count"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.fsync.exceeded_threshold.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of times fsync duration has exceeded warning threshold.
        # TODO: add unit: {events}
      }
    }
    
    chart {
      name = "zookeeper.latency.avg"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.latency.avg"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Average time in milliseconds for requests to be processed.
        # TODO: add unit: ms
      }
    }
    
    chart {
      name = "zookeeper.latency.max"
      rank = "8"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.latency.max"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Maximum time in milliseconds for requests to be processed.
        # TODO: add unit: ms
      }
    }
    
    chart {
      name = "zookeeper.latency.min"
      rank = "9"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.latency.min"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Minimum time in milliseconds for requests to be processed.
        # TODO: add unit: ms
      }
    }
    
    chart {
      name = "zookeeper.packet.count"
      rank = "10"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.packet.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "direction"]
        }
        
        # TODO: add description: The number of ZooKeeper packets received or sent by a server.
        # TODO: add unit: {packets}
      }
    }
    
    chart {
      name = "zookeeper.request.active"
      rank = "11"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.request.active"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of currently executing requests.
        # TODO: add unit: {requests}
      }
    }
    
    chart {
      name = "zookeeper.sync.pending"
      rank = "12"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.sync.pending"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of pending syncs from the followers. Only exposed by the leader.
        # TODO: add unit: {syncs}
      }
    }
    
    chart {
      name = "zookeeper.watch.count"
      rank = "13"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.watch.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of watches placed on Z-Nodes on a ZooKeeper server.
        # TODO: add unit: {watches}
      }
    }
    
    chart {
      name = "zookeeper.znode.count"
      rank = "14"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "zookeeper.znode.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of z-nodes that a ZooKeeper server has in its data tree.
        # TODO: add unit: {znodes}
      }
    }
}