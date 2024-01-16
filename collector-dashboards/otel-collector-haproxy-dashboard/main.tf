terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.86.1"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_haproxy_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "HAProxy - Overview"
  dashboard_description = "An overview of your HAProxy frontend and backend servers, helping you spot issues like rising error rates or disparities between your frontend and backend traffic."

  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"

    chart {
      name   = "Memory Allocated In Pool"
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
        query_string = "metric haproxy_process_pool_allocated_bytes | reduce mean | group_by [], sum"
      }
    }
    chart {
      name   = "Backend Backup Servers"
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
        query_string = "metric haproxy_backend_backup_servers | reduce mean | group_by [], sum"
      }
    }
    chart {
      name   = "Backend Active Servers"
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
        query_string = "metric haproxy_backend_active_servers | latest | group_by [], sum"
      }
    }
  }
  group {
    rank            = 3
    title           = "Server"
    visibility_type = "explicit"

    chart {
      name   = "Up Instances"
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
        query_string = "metric haproxy_server_check_status | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Number Of Connection Attempts"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_server_connection_attempts_total | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Number Of Sessions"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_server_sessions_total | rate | group_by [], sum"
      }
    }
  }
  group {
    rank            = 2
    title           = "Status Codes"
    visibility_type = "explicit"

    chart {
      name   = "HTTP 2xx Codes"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_frontend_http_responses_total | filter (code == \"2xx\") | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_backend_http_responses_total | filter (code == \"2xx\") | rate | group_by [], sum"
      }
    }
    chart {
      name   = "HTTP 4xx Codes"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_frontend_http_responses_total | filter (code == \"4xx\") | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_backend_http_responses_total | filter (code == \"4xx\") | rate | group_by [], sum"
      }
    }
    chart {
      name   = "HTTP 5xx Codes"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_frontend_http_responses_total | filter (code == \"5xx\") | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_backend_http_responses_total | filter (code == \"5xx\") | rate | group_by [], sum"
      }
    }
    chart {
      name   = "HTTP 3xx Codes"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_frontend_http_responses_total | filter (code == \"3xx\") | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_backend_http_responses_total | filter (code == \"3xx\") | rate | group_by [], sum"
      }
    }
    chart {
      name   = "HTTP 1xx Codes"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_frontend_http_responses_total | filter (code == \"1xx\") | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_backend_http_responses_total | filter (code == \"1xx\") | rate | group_by [], sum"
      }
    }
  }
  group {
    rank            = 1
    title           = "Frontend & Backend"
    visibility_type = "explicit"

    chart {
      name   = "Frontend Network Traffic"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_frontend_bytes_in_total | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_frontend_bytes_out_total | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Backend Network Traffic"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_backend_bytes_out_total | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_backend_bytes_in_total | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Errors"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_frontend_request_errors_total | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_backend_response_errors_total | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Frontend Denials"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_frontend_requests_denied_total | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_frontend_responses_denied_total | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Backend 2xx Percentage"
      type   = "timeseries"
      rank   = 3
      x_pos  = 16
      y_pos  = 24
      width  = 16
      height = 8

      query {
        query_name   = "((a/b)*100)"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric haproxy_backend_http_responses_total | filter (code == \"2xx\") | rate 5m, 5m | group_by [], sum;\n  b = metric haproxy_backend_http_responses_total | rate 5m, 5m | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0 | reduce 5m, mean"
      }
    }
    chart {
      name   = "Backend Denials"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_backend_requests_denied_total | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_backend_responses_denied_total | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Frontend Requests"
      type   = "timeseries"
      rank   = 5
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_frontend_http_requests_total | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Backend Requests"
      type   = "timeseries"
      rank   = 6
      x_pos  = 16
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric haproxy_backend_http_requests_total | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Frontend 2xx Percentage"
      type   = "timeseries"
      rank   = 7
      x_pos  = 0
      y_pos  = 24
      width  = 16
      height = 8

      query {
        query_name   = "((a/b)*100)"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric haproxy_frontend_http_responses_total | filter (code == \"2xx\") | rate 5m, 5m | group_by [], sum;\n  b = metric haproxy_frontend_http_responses_total | rate 5m, 5m | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0 | reduce 5m, mean"
      }
    }
  }
}