terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.92.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_vault_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Vault - Overview"
  dashboard_description = "This dashboard provides a high-level overview of your Vault clusters so you can monitor its performance and cluster health."

  group {
    rank            = 3
    title           = "Storage Backend"
    visibility_type = "explicit"

    chart {
      name   = "Consul GET Duration"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric vault_consul_get_sum | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Consul LIST Duration"
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
        query_string = "metric vault_consul_list_sum | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Consul DELETE Duration"
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
        query_string = "metric vault_consul_delete_sum | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Consul PUT Duration"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric vault_consul_put_sum | rate | group_by [], sum"
      }
    }
  }
  group {
    rank            = 4
    title           = "Token"
    visibility_type = "explicit"

    chart {
      name   = "Available"
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
        query_string = "metric vault_token_count | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Lookups"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric vault_token_lookup_count | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Created"
      type   = "timeseries"
      rank   = 2
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric vault_token_create_count | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Pending"
      type   = "timeseries"
      rank   = 3
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "(a-b)"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric vault_token_create_count | rate | group_by [], sum;\n  b = metric vault_token_store_count | rate | group_by [], sum;\njoin ((a - b)), a=0, b=0"
      }
    }
  }
  group {
    rank            = 5
    title           = "Audit"
    visibility_type = "explicit"

    chart {
      name   = "Log Request Failures"
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
        query_string = "metric vault_audit_log_request_failure | delta 5m | group_by [], max"
      }
    }
    chart {
      name   = "Log Response Failures"
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
        query_string = "metric vault_audit_log_response_failure | delta 5m | group_by [], max"
      }
    }
    chart {
      name   = "Log Requests"
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
        query_string = "metric vault_core_handle_request_count | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric vault_audit_log_response_count | rate | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric vault_audit_log_request_count | rate | group_by [], sum"
      }
    }
  }
  group {
    rank            = 6
    title           = "Policy"
    visibility_type = "explicit"

    chart {
      name   = "Get"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric vault_policy_get_policy_count | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Set"
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
        query_string = "metric vault_policy_set_policy_count | rate | group_by [], sum"
      }
    }
  }
  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"
  }
  group {
    rank            = 1
    title           = "Performance"
    visibility_type = "explicit"

    chart {
      name   = "Login Requests"
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
        query_string = "metric vault_core_handle_login_request_count | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Login Request Latency"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "(a/b)"
        display      = "area"
        hidden       = false
        query_string = "with\n  a = metric vault_core_handle_login_request_sum | rate | group_by [], sum;\n  b = metric vault_core_handle_login_request_count | rate | group_by [], sum;\njoin ((a / b)), a=0, b=0"
      }
    }
    chart {
      name   = "Leases"
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
        query_string = "metric vault_expire_num_leases | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Requests"
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
        query_string = "metric vault_core_handle_request_count | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Request Latency"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "(a/b)"
        display      = "area"
        hidden       = false
        query_string = "with\n  a = metric vault_core_handle_request_sum | rate | group_by [], sum;\n  b = metric vault_core_handle_request_count | rate | group_by [], sum;\njoin ((a / b)), a=0, b=0"
      }
    }
  }
  group {
    rank            = 2
    title           = "Runtime"
    visibility_type = "explicit"

    chart {
      name   = "Garbage Collector Pause Time"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric vault_runtime_gc_pause_ns_sum | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Memory Allocation"
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
        query_string = "metric vault_runtime_alloc_bytes | latest | group_by [], max"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric vault_runtime_sys_bytes | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Goroutines"
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
        query_string = "metric vault_runtime_num_goroutines | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Heap Objects Used"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "(a/b)"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric go_memstats_heap_objects | latest | group_by [], sum;\n  b = metric vault_runtime_malloc_count | latest | group_by [], sum;\njoin ((a / b)), a=0, b=0"
      }
    }
  }
}