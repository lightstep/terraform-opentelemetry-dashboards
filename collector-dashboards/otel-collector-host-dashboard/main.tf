terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_host_dashboard" {

  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry / Host"
  dashboard_description = "Monitor Host with this metrics overview dashboard."

  chart {
    name = "Disk Read / Write bytes"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric system.disk.operations | rate | group_by ["direction"], sum
EOT
    }
  }

  chart {
    name = "Disk Read / Write time"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric system.disk.operation_time | rate | group_by ["direction"], sum
EOT
    }
  }

  chart {
    name = "Disk Usage"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric system.filesystem.usage | latest | group_by ["state"], sum
EOT
    }
  }

  chart {
    name = "Total disk"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric system.filesystem.usage | latest | group_by [], sum
EOT
    }
  }

  chart {
    name = "Inode usage"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric system.filesystem.inodes.usage | latest | group_by ["state"], sum
EOT
    }
  }

  chart {
    name = "Memory used/available"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric system.memory.usage | latest | group_by ["state"], sum
EOT
    }
  }

  chart {
    name = "Paging Usage used/free"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric system.paging.usage | latest | group_by ["state"], sum
EOT
    }
  }

  chart {
    name = "Paging Operations"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric system.paging.operations | rate | group_by ["direction"], sum
EOT
    }
  }

  chart {
    name = "Paging Faults"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric system.paging.faults | rate | group_by ["type"], sum
EOT
    }
  }

  chart {
    name = "CPU"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric system.cpu.time | rate | group_by ["cpu", "state"], sum
EOT
    }
  }
}
