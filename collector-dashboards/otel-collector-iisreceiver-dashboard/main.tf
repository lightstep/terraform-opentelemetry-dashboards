terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_iisreceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry iisreceiver Integration"
  dashboard_description = ""

  chart {
    name = "iis.connection.active"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric iis.connection.active | rate | group_by [], sum"
    }

  }

  chart {
    name = "iis.connection.anonymous"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric iis.connection.anonymous | rate | group_by [], sum"
    }

  }

  chart {
    name = "iis.connection.attempt.count"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric iis.connection.attempt.count | rate | group_by [], sum"
    }

  }

  chart {
    name = "iis.network.blocked"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric iis.network.blocked | rate | group_by [], sum"
    }

  }

  chart {
    name = "iis.network.file.count"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric iis.network.file.count | rate | group_by ["direction"], sum
EOT
    }

  }

  chart {
    name = "iis.network.io"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric iis.network.io | rate | group_by ["direction"], sum
EOT
    }

  }

  chart {
    name = "iis.request.count"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric iis.request.count | rate | group_by ["request"], sum
EOT
    }

  }

  chart {
    name = "iis.request.queue.age.max"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric iis.request.queue.age.max | latest | group_by [], sum"
    }

  }

  chart {
    name = "iis.request.queue.count"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric iis.request.queue.count | rate | group_by [], sum"
    }

  }

  chart {
    name = "iis.request.rejected"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric iis.request.rejected | rate | group_by [], sum"
    }

  }

  chart {
    name = "iis.thread.active"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric iis.thread.active | rate | group_by [], sum"
    }

  }

  chart {
    name = "iis.uptime"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric iis.uptime | latest | group_by [], sum"
    }

  }

}
