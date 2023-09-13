terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_envoy_dashboard" {
  project_name          = var.cloud_observability_project
  dashboard_name        = "Envoy - Overview"
  dashboard_description = "This dashboard provides a high-level overview of your Envoy cluster so you can monitor its performance and resource usage."

  group {
    rank            = 3
    title           = "Listeners"
    visibility_type = "explicit"

    chart {
      name   = "Listeners Success Rate (Excluding Admin Interface)"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "((a/b)*100)"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric envoy_http_downstream_rq_xx | filter ((((envoy_response_code_class != \"4\") && (envoy_response_code_class != 4)) && (envoy_response_code_class != 4.0)) && (((envoy_response_code_class != \"5\") && (envoy_response_code_class != 5)) && (envoy_response_code_class != 5.0))) | rate | group_by [], sum;\n  b = metric envoy_http_downstream_rq_completed | filter (((envoy_response_code_class == \"2\") || (envoy_response_code_class == 2)) || (envoy_response_code_class == 2.0)) | rate | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Listeners Response Time Percentiles"
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
        query_string = "metric envoy_http_downstream_rq_time | delta | group_by [], sum | point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)"
      }
    }
    chart {
      name   = "Listener Traffic"
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
        query_string = "metric envoy_http_downstream_rq_completed | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric envoy_http_downstream_cx_tx_bytes_total | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Requests Rejected By Reason"
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
        query_string = "metric envoy_http_no_route | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric envoy_http_no_cluster | rate | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric envoy_http_downstream_cx_protocol_error | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Active Connections Per Type and Listener"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric envoy_http_downstream_cx_active | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric envoy_http_downstream_cx_http2_active | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric envoy_http_downstream_cx_http1_active | latest | group_by [], sum"
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
    title           = "Overview"
    visibility_type = "explicit"

    chart {
      name   = "Incoming Success Rate (Non-5xx Responses)"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "((1-(a/b))*100)"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric envoy_cluster_upstream_rq_xx | filter (((envoy_response_code_class == \"5\") || (envoy_response_code_class == 5)) || (envoy_response_code_class == 5.0)) | rate 5m, 5m | group_by [], mean;\n  b = metric envoy_cluster_upstream_rq_completed | rate 5m, 5m | group_by [], mean;\njoin (((1-(a / b))*100)), a=0, b=0 | reduce 5m, mean"
      }
    }
    chart {
      name   = "Incoming Requests Volume"
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
        query_string = "metric envoy_cluster_upstream_rq_xx | rate 5m | group_by [], mean"
      }
    }
    chart {
      name   = "Incoming Requests by Release"
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
        query_string = "metric envoy_cluster_upstream_rq_total | rate 5m | group_by [], mean"
      }
    }
  }
  group {
    rank            = 2
    title           = "Upstream Clusters"
    visibility_type = "explicit"

    chart {
      name   = "Upstream Response 2xx (% Breakdown)"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "((a/b)*100)"
        display      = "bar"
        hidden       = false
        query_string = "with\n  a = metric envoy_cluster_upstream_rq_xx | filter (((envoy_response_code_class == \"2\") || (envoy_response_code_class == 2)) || (envoy_response_code_class == 2.0)) | rate | group_by [], sum;\n  b = metric envoy_cluster_upstream_rq_completed | rate | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Upstream Response 3xx (% Breakdown)"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "((a/b)*100)"
        display      = "bar"
        hidden       = false
        query_string = "with\n  a = metric envoy_cluster_upstream_rq_xx | filter (((envoy_response_code_class == \"3\") || (envoy_response_code_class == 3)) || (envoy_response_code_class == 3.0)) | rate | group_by [], sum;\n  b = metric envoy_cluster_upstream_rq_completed | rate | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Upstream Response 4xx (% Breakdown)"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "((a/b)*100)"
        display      = "bar"
        hidden       = false
        query_string = "with\n  a = metric envoy_cluster_upstream_rq_xx | filter (((envoy_response_code_class == \"4\") || (envoy_response_code_class == 4)) || (envoy_response_code_class == 4.0)) | rate | group_by [], sum;\n  b = metric envoy_cluster_upstream_rq_completed | rate | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Upstream Response 5xx (% Breakdown)"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "((a/b)*100)"
        display      = "bar"
        hidden       = false
        query_string = "with\n  a = metric envoy_cluster_upstream_rq_xx | filter (((envoy_response_code_class == \"5\") || (envoy_response_code_class == 5)) || (envoy_response_code_class == 5.0)) | rate | group_by [], sum;\n  b = metric envoy_cluster_upstream_rq_completed | rate | group_by [], sum;\njoin (((a / b)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Upstream Response 2xx (Total Breakdown)"
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
        query_string = "metric envoy_cluster_upstream_rq_xx | filter (((envoy_response_code_class == \"2\") || (envoy_response_code_class == 2)) || (envoy_response_code_class == 2.0)) | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Upstream Response 3xx (Total Breakdown)"
      type   = "timeseries"
      rank   = 5
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric envoy_cluster_upstream_rq_xx | filter (((envoy_response_code_class == \"3\") || (envoy_response_code_class == 3)) || (envoy_response_code_class == 3.0)) | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Upstream Response 4xx (Total Breakdown)"
      type   = "timeseries"
      rank   = 6
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric envoy_cluster_upstream_rq_xx | filter (((envoy_response_code_class == \"4\") || (envoy_response_code_class == 4)) || (envoy_response_code_class == 4.0)) | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Upstream Response 5xx (Total Breakdown)"
      type   = "timeseries"
      rank   = 7
      x_pos  = 16
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric envoy_cluster_upstream_rq_xx | filter (((envoy_response_code_class == \"5\") || (envoy_response_code_class == 5)) || (envoy_response_code_class == 5.0)) | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Upstream p99 Response Time"
      type   = "timeseries"
      rank   = 8
      x_pos  = 32
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric envoy_cluster_upstream_rq_time | delta | group_by [], sum | point percentile(value, 99.0)"
      }
    }
    chart {
      name   = "Average Upstream Traffic Rate"
      type   = "timeseries"
      rank   = 9
      x_pos  = 0
      y_pos  = 24
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric envoy_cluster_upstream_rq_total | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Cluster Load Balancer Panics"
      type   = "timeseries"
      rank   = 10
      x_pos  = 16
      y_pos  = 24
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric envoy_cluster_lb_healthy_panic | rate | group_by [], sum"
      }
    }
  }
}