terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.7"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_hostmetrics_disk_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Host Metrics / Disk"
  dashboard_description = "Hostmetrics-Disk Metrics"

  chart {
    name = "Read / Write bytes"
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
    name = "Read / Write time"
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
    name = "Usage"
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
      query_string = "metric system.filesystem.usage | latest | group_by [], sum"
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

}
