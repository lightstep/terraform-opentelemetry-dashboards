terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_squid_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Squid - Overview"
  dashboard_description = "A squid overview dashboard displays real-time metrics including bytes hit rate, cache hit rate, error rate, client requests, and client traffic, providing insights into the performance and usage of the proxy server."

  chart {
    name = "Bytes Hit Rate"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a/b)"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
with
  a = metric squid_client_http_hit_kbytes_out_bytes_total | rate 5m | group_by [], sum;
  b = metric squid_client_http_kbytes_out_kbytes_total | rate 5m | group_by [], sum;
join ((a / b)), a=0, b=0
EOT
    }

  }

  chart {
    name = "Catch Hit Rate"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a/b)"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
with
  a = metric squid_client_http_hits_total | rate 5m | group_by [], sum;
  b = metric squid_client_http_requests_total | rate 5m | group_by [], sum;
join ((a / b)), a=0, b=0
EOT
    }

  }

  chart {
    name = "Error Rate"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a/b)"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
with
  a = metric squid_client_http_errors_total | rate 5m | group_by [], sum;
  b = metric squid_client_http_requests_total | rate 5m | group_by [], sum;
join ((a / b)), a=0, b=0
EOT
    }

  }

  chart {
    name = "Client Requests"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric squid_client_http_requests_total | rate 5m | group_by [], sum"
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = "metric squid_client_http_hits_total | rate 5m | group_by [], sum"
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = "metric squid_client_http_errors_total | rate 5m | group_by [], sum"
    }

  }

  chart {
    name = "Client Traffic"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric squid_client_http_kbytes_in_kbytes_total | rate 5m | group_by [], sum"
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = "metric squid_client_http_kbytes_out_kbytes_total | rate 5m | group_by [], sum"
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = "metric squid_client_http_hit_kbytes_out_bytes_total | rate 5m | group_by [], sum"
    }

  }

}
