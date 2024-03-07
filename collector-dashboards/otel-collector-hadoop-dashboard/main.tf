terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.92.0"
    }
  }
  required_version = ">= v1.0.11"
}


resource "lightstep_dashboard" "otel_collector_hadoop_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Hadoop"
  dashboard_description = "Monitor OpenTelemetry Hadoop metrics"

  chart {
    name = "Data Node Count"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric hadoop.name_node.data_node.count | latest | group_by [], sum"
    }

  }

  chart {
    name = "Volume Failed"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric hadoop.name_node.volume.failed | latest | group_by [], sum"
    }

  }

  chart {
    name = "File Load"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric hadoop.name_node.file.load | latest | group_by [], sum"
    }

  }

  chart {
    name = "Capacity Usage"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric hadoop.name_node.capacity.usage | latest | group_by [], sum"
    }

  }

  chart {
    name = "Block Missing"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric hadoop.name_node.block.missing | latest | group_by [], sum"
    }

  }

  chart {
    name = "Block Corrupt"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric hadoop.name_node.block.corrupt | latest | group_by [], sum"
    }

  }

  chart {
    name = "Capacity Limit"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric hadoop.name_node.capacity.limit | latest | group_by [], sum"
    }

  }

  chart {
    name = "File Count"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric hadoop.name_node.file.count | latest | group_by [], sum"
    }

  }

  chart {
    name = "Block Count"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric hadoop.name_node.block.count | latest | group_by [], sum"
    }

  }

  chart {
    name = "Memory Pool Max/Init/Used"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = "metric jvm.memory.pool.init | latest | group_by [], sum"
    }

    query {
      query_name   = "b"
      display      = "area"
      hidden       = false
      query_string = "metric jvm.memory.pool.max | latest | group_by [], sum"
    }

    query {
      query_name   = "c"
      display      = "area"
      hidden       = false
      query_string = "metric jvm.memory.pool.used | latest | group_by [], sum"
    }

  }

}

