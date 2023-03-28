terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_hostmetrics_cpu_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry / Host Metrics / CPU"
  dashboard_description = "Monitor Host CPU metrics."

  chart {
    name = "idle"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric system.cpu.time | filter (state == "idle") | rate | group_by ["cpu"], sum
EOT
    }

  }

  chart {
    name = "interrupt"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric system.cpu.time | filter (state == "interrupt") | rate | group_by ["cpu"], sum
EOT
    }

  }

  chart {
    name = "nice"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric system.cpu.time | filter (state == "nice") | rate | group_by ["cpu"], sum
EOT
    }

  }

  chart {
    name = "softirq"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric system.cpu.time | filter (state == "softirq") | rate | group_by ["cpu"], sum
EOT
    }

  }

  chart {
    name = "steal"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric system.cpu.time | filter (state == "steal") | rate | group_by ["cpu"], sum
EOT
    }

  }

  chart {
    name = "system"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric system.cpu.time | filter (state == "system") | rate | group_by ["cpu"], sum
EOT
    }

  }

  chart {
    name = "user"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric system.cpu.time | filter (state == "user") | rate | group_by ["cpu"], sum
EOT
    }

  }

  chart {
    name = "wait"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric system.cpu.time | filter (state == "wait") | rate | group_by ["cpu"], sum
EOT
    }

  }

}
