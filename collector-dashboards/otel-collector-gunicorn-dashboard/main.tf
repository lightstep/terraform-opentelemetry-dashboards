terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.84.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_gunicorn_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Gunicorn - Overview"
  dashboard_description = "Track request count, duration, and status codes to monitor the performance and availability of Gunicorn web server."

  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"

    chart {
      name   = "Request Count (Last 24 Hours)"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric gunicorn.requests | delta 1d | group_by [], sum"
      }
    }
    chart {
      name   = "Request Per Sec"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric gunicorn.requests | rate 1s | group_by [], sum"
      }
    }
    chart {
      name   = "Request Average Duration"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric gunicorn.request.duration | latest | group_by [], mean"
      }
    }
    chart {
      name   = "Current Workers"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric gunicorn.workers | latest | group_by [], sum"
      }
    }
  }
  group {
    rank            = 1
    title           = "Status Code Count"
    visibility_type = "explicit"

    chart {
      name   = "200 (Last 24 Hours)"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric gunicorn.request.status.200 | delta 1d | group_by [], sum"
      }
    }
    chart {
      name   = "300 (Last 24 Hours)"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric gunicorn.request.status.300 | delta 1d | group_by [], sum"
      }
    }
    chart {
      name   = "400 (Last 24 Hours)"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric gunicorn.request.status.300 | delta 1d | group_by [], sum"
      }
    }
    chart {
      name   = "500 (Last 24 Hours)"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric gunicorn.request.status.500 | delta 1d | group_by [], sum"
      }
    }
  }
  group {
    rank            = 2
    title           = "Status Code Rate"
    visibility_type = "explicit"

    chart {
      name   = "200"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric gunicorn.request.status.200 | rate | group_by [], sum"
      }
    }
    chart {
      name   = "300"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric gunicorn.request.status.300 | rate | group_by [], sum"
      }
    }
    chart {
      name   = "400"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric gunicorn.request.status.400 | rate | group_by [], sum"
      }
    }
    chart {
      name   = "500"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric gunicorn.request.status.500 | rate | group_by [], sum"
      }
    }
  }
}
