terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.4"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_varnish_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Varnish - Overview"
  dashboard_description = "An overview of Varnish caches, so you can monitor cache performance and resource utilization, as well as the health of connections to backend servers."

  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"

    chart {
      name   = "Frontend Requests"
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
        query_string = "metric varnish_main_client_req | rate 5m | group_by [], sum"
      }
    }
    chart {
      name   = "Backend Requests"
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
        query_string = "metric varnish_main_backend_req | rate 5m | group_by [], sum"
      }
    }
    chart {
      name   = "Loaded VMODs"
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
        query_string = "metric varnish_main_vmods | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Cache Hit Rate"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "(a/b)"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric varnish_main_cache_hit | rate 5m, 5m | group_by [], sum;\n  b = metric varnish_main_client_req | rate 5m, 5m | group_by [], sum;\njoin ((a / b)), a=0, b=0 | reduce 5m, mean"
      }
    }
    chart {
      name   = "Requests"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_client_req | rate 5m | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_backend_req | rate 5m | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_fetch_total | rate 5m | group_by [], sum"
      }
    }
    chart {
      name   = "Cache"
      type   = "timeseries"
      rank   = 5
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_n_expired | rate 5m | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_n_lru_moved | rate 5m | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_n_lru_nuked | rate 5m | group_by [], sum"
      }
      query {
        query_name   = "d"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_sma_g_bytes | filter (type == \"s0\") | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Backend Connections"
      type   = "timeseries"
      rank   = 6
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_backend_conn | rate 1m | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_backend_recycle | rate 1m | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_backend_reuse | rate 1m | group_by [], sum"
      }
      query {
        query_name   = "d"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_backend_fail | rate 1m | group_by [], sum"
      }
      query {
        query_name   = "e"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_backend_unhealthy | rate 1m | group_by [], sum"
      }
      query {
        query_name   = "f"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_backend_busy | rate 1m | group_by [], sum"
      }
      query {
        query_name   = "g"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_backend_req | rate 1m | group_by [], sum"
      }
      query {
        query_name   = "h"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_backend_retry | rate 1m | group_by [], sum"
      }
      query {
        query_name   = "i"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_backend_conn | rate 1m | group_by [], sum"
      }
    }
    chart {
      name   = "Sessions"
      type   = "timeseries"
      rank   = 7
      x_pos  = 16
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_sessions | rate 1m | group_by [\"type\"], sum"
      }
    }
    chart {
      name   = "Threads"
      type   = "timeseries"
      rank   = 8
      x_pos  = 32
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_threads_created | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_threads_destroyed | rate | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_threads_failed | rate | group_by [], sum"
      }
      query {
        query_name   = "d"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_threads_limited | rate | group_by [], sum"
      }
      query {
        query_name   = "e"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_threads | latest | group_by [], sum"
      }
      query {
        query_name   = "f"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_thread_queue_len | latest | group_by [], sum"
      }
      query {
        query_name   = "g"
        display      = "area"
        hidden       = false
        query_string = "metric varnish_main_pools | latest | group_by [], sum"
      }
    }
  }
  group {
    rank            = 1
    title           = "Cache Percentage Status"
    visibility_type = "explicit"

    chart {
      name   = "Pass"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "((a/b)*100)"
        display      = "area"
        hidden       = false
        query_string = "with\n  a = metric varnish_main_cache_hitpass | rate 5m | group_by [], sum;\n  b = metric varnish_main_client_req | rate | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Hit"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "((a/b)*100)"
        display      = "area"
        hidden       = false
        query_string = "with\n  a = metric varnish_main_cache_hit | rate 5m | group_by [], sum;\n  b = metric varnish_main_client_req | rate | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Miss"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "(100-((a/b)*100))"
        display      = "area"
        hidden       = false
        query_string = "with\n  a = metric varnish_main_cache_hit | rate 5m | group_by [], sum;\n  b = metric varnish_main_client_req | rate | group_by [], sum;\njoin ((100-((a / b)*100))), a=0, b=0"
      }
    }
  }
  group {
    rank            = 2
    title           = "Network"
    visibility_type = "explicit"

    chart {
      name   = "Frontend"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "(a+b)"
        display      = "area"
        hidden       = false
        query_string = "with\n  a = metric varnish_main_s_resp_hdrbytes | rate 5m | group_by [], sum;\n  b = metric varnish_main_s_resp_bodybytes | rate 5m | group_by [], sum;\njoin ((a + b)), a=0, b=0"
      }
    }
    chart {
      name   = "Backends All Together"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "(a+b)"
        display      = "area"
        hidden       = false
        query_string = "with\n  a = metric varnish_backend_beresp_hdrbytes | rate 5m | group_by [], sum;\n  b = metric varnish_backend_beresp_bodybytes | rate 5m | group_by [], sum;\njoin ((a + b)), a=0, b=0"
      }
    }
    chart {
      name   = "Backend"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "(a+b)"
        display      = "area"
        hidden       = false
        query_string = "with\n  a = metric varnish_backend_beresp_hdrbytes | rate 5m | group_by [\"backend\"], sum;\n  b = metric varnish_backend_beresp_bodybytes | rate 5m | group_by [\"backend\"], sum;\njoin ((a + b)), a=0, b=0"
      }
    }
  }
}
