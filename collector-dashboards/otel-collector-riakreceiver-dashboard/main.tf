terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.92.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_riakreceiver_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "riakreceiver Integration"



  chart {
    name = "riak.memory.limit"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "riak.memory.limit"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The amount of memory allocated to the node.
      # TODO: add unit: By
    }
  }

  chart {
    name = "riak.node.operation.count"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "riak.node.operation.count"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["request"]
      }

      # TODO: add description: The number of operations performed by the node.
      # TODO: add unit: {operation}
    }
  }

  chart {
    name = "riak.node.operation.time.mean"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "riak.node.operation.time.mean"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["request"]
      }

      # TODO: add description: The mean time between request and response for operations performed by the node over the last minute.
      # TODO: add unit: us
    }
  }

  chart {
    name = "riak.node.read_repair.count"
    rank = "3"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "riak.node.read_repair.count"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The number of read repairs performed by the node.
      # TODO: add unit: {read_repair}
    }
  }

  chart {
    name = "riak.vnode.index.operation.count"
    rank = "4"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "riak.vnode.index.operation.count"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["operation"]
      }

      # TODO: add description: The number of index operations performed by vnodes on the node.
      # TODO: add unit: {operation}
    }
  }

  chart {
    name = "riak.vnode.operation.count"
    rank = "5"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "riak.vnode.operation.count"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["request"]
      }

      # TODO: add description: The number of operations performed by vnodes on the node.
      # TODO: add unit: {operation}
    }
  }
}