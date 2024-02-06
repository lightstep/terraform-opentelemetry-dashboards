terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.89.0"
    }
  }
  required_version = ">= v1.0.11"
}


resource "lightstep_dashboard" "otel_collector_hbase_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "HBase"
  dashboard_description = "Monitor OpenTelemetry HBase metrics"

  chart {
    name = "Master Region Server Count"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric hbase.master.region_server.count | latest | group_by [], sum"
    }

  }

  chart {
    name = "Region Server Active Handler Count"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric hbase.region_server.active_handler.count | latest | group_by [], sum"
    }

  }

  chart {
    name = "Region Server Authentication Count"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric hbase.region_server.authentication.count | latest | group_by [], sum"
    }

  }

  chart {
    name = "Region Server Block Cache Operation Count"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric hbase.region_server.block_cache.operation.count | latest | group_by [], sum"
    }

  }

  chart {
    name = "Region Server Blocked Update Time"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric hbase.region_server.blocked_update.time | latest | group_by [], sum"
    }

  }

  chart {
    name = "Region Server Disk Store File Size"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric hbase.region_server.disk.store_file.size | latest | group_by [], sum"
    }

  }

  chart {
    name = "Region Server Files Local"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric hbase.region_server.files.local | latest | group_by [], sum"
    }

  }

  chart {
    name = "Region Server Connection Count"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric hbase.region_server_connection.count | latest | group_by [], sum"
    }

  }

  chart {
    name = "Region Server Operation Append Latency"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = "metric hbase.region_server.operation.append.latency.max | latest | group_by [], sum"
    }

    query {
      query_name   = "b"
      display      = "area"
      hidden       = false
      query_string = "metric hbase.region_server.operation.append.latency.min | latest | group_by [], sum"
    }

    query {
      query_name   = "c"
      display      = "area"
      hidden       = false
      query_string = "metric hbase.region_server.operation.delete.latency.max | latest | group_by [], sum"
    }

    query {
      query_name   = "d"
      display      = "area"
      hidden       = false
      query_string = "metric hbase.region_server.operation.delete.latency.min | latest | group_by [], sum"
    }

    query {
      query_name   = "e"
      display      = "area"
      hidden       = false
      query_string = "metric hbase.region_server.operation.get.latency.max | latest | group_by [], sum"
    }

    query {
      query_name   = "f"
      display      = "area"
      hidden       = false
      query_string = "metric hbase.region_server.operation.get.latency.min | latest | group_by [], sum"
    }

    query {
      query_name   = "g"
      display      = "area"
      hidden       = false
      query_string = "metric hbase.region_server.operation.increment.latency.max | latest | group_by [], sum"
    }

    query {
      query_name   = "h"
      display      = "area"
      hidden       = false
      query_string = "metric hbase.region_server.operation.increment.latency.min | latest | group_by [], sum"
    }

    query {
      query_name   = "i"
      display      = "area"
      hidden       = false
      query_string = "metric hbase.region_server.operation.replay.latency.max | latest | group_by [], sum"
    }

    query {
      query_name   = "j"
      display      = "area"
      hidden       = false
      query_string = "metric hbase.region_server.operation.replay.latency.min | latest | group_by [], sum"
    }

  }

}

