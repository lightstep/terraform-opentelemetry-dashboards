terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_iisreceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry iisreceiver Integration"
  dashboard_description = ""

  chart {
    name = "Active connections"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric windows_iis_current_connections | rate | group_by [], sum"
    }

  }

  chart {
    name = "Anonymous users"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric windows_iis_current_anonymous_users | rate | group_by [], sum"
    }

  }

  chart {
    name = "Worker processes"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric windows_iis_current_worker_processes | rate | group_by [], sum"
    }

  }

  chart {
    name = "Blocked requests"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric windows_iis_current_blocked_async_io_requests | rate | group_by [], sum"
    }

  }

  chart {
    name = "Total bytes received"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric windows_iis_received_bytes_total | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Failed Worker Processes"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric windows_iis_recent_worker_process_failures | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Current CGI requests"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric windows_iis_current_cgi_requests | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Cache size in bytes"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric windows_iis_worker_file_cache_memory_bytes | latest | group_by [], sum"
    }

  }

  chart {
    name = "URI blocks cached"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric windows_iis_worker_uri_cache_items | rate | group_by [], sum"
    }

  }

  chart {
    name = "Active threads in the worker process"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric windows_iis_worker_threads | rate | group_by [], sum"
    }

  }

}