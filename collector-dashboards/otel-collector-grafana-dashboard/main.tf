terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.87.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_grafana_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Grafana"
  dashboard_description = "Visualize and track internal system metrics with ease using Grafana's comprehensive monitoring dashboard."

  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"
  }
  group {
    rank            = 3
    title           = "Dataproxy Stats"
    visibility_type = "explicit"

    chart {
      name   = "Dataproxy Request Quantiles"
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
        query_string = "metric grafana_api_dataproxy_request_all_milliseconds_p50 | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_api_dataproxy_request_all_milliseconds_p90 | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_api_dataproxy_request_all_milliseconds_p99 | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Dataproxy Request Avg (5 min)"
      type   = "timeseries"
      rank   = 6
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric grafana_api_dataproxy_request_all_milliseconds_sum | filter (service.instance.id == $instance) | rate 5m, 5m | group_by [], sum;\n  b = metric grafana_api_dataproxy_request_all_milliseconds_count | filter (service.instance.id == $instance) | rate 5m, 5m | group_by [], sum;\njoin ((a / b)), a=0, b=0 | reduce 5m, min"
      }
    }
  }
  group {
    rank            = 1
    title           = "General Counters"
    visibility_type = "explicit"

    chart {
      name   = "Organizations Count"
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
        query_string = "metric grafana_stat_total_orgs | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Users Count"
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
        query_string = "metric grafana_stat_total_users | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Datasources Count"
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
        query_string = "metric grafana_stat_totals_datasource | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Playlists Count"
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
        query_string = "metric grafana_stat_total_playlists | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Folders Count"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric grafana_stat_totals_folder | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Dashboards Count"
      type   = "timeseries"
      rank   = 5
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric grafana_stat_totals_dashboard | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
    }
  }
  group {
    rank            = 2
    title           = "Response Codes an"
    visibility_type = "explicit"

    chart {
      name   = "Total Response Statuses"
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
        query_string = "metric grafana_api_response_status_total | filter (service.instance.id == $instance) | rate | group_by [\"code\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_page_response_status_total | filter (service.instance.id == $instance) | rate | group_by [\"code\"], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_proxy_response_status_total | filter (service.instance.id == $instance) | rate | group_by [\"code\"], sum"
      }
    }
    chart {
      name   = "Login Counts"
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
        query_string = "metric grafana_api_login_post_total | filter (service.instance.id == $instance) | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_api_login_oauth_total | filter (service.instance.id == $instance) | rate | group_by [], sum"
      }
    }
  }
  group {
    rank            = 4
    title           = "Dashboard Stats"
    visibility_type = "explicit"

    chart {
      name   = "Dashboard Get Duration Quantiles"
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
        query_string = "metric grafana_api_dashboard_get_milliseconds_p50 | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_api_dashboard_get_milliseconds_p90 | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_api_dashboard_get_milliseconds_p99 | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Dashboard Get Duration Avg (5 min)"
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
        query_string = "with\n  a = metric grafana_api_dashboard_get_milliseconds_sum | filter (service.instance.id == $instance) | rate 5m, 5m | group_by [], sum;\n  b = metric grafana_api_dashboard_get_milliseconds_count | filter (service.instance.id == $instance) | rate 5m, 5m | group_by [], sum;\njoin ((a / b)), a=0, b=0 | reduce 5m, min"
      }
    }
    chart {
      name   = "Dashboard Search Duration Quantiles"
      type   = "timeseries"
      rank   = 2
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_api_dashboard_search_milliseconds_p50 | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_api_dashboard_search_milliseconds_p90 | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_api_dashboard_search_milliseconds_p99 | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Dashboard Search Duration Avg (5 min)"
      type   = "timeseries"
      rank   = 3
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric grafana_api_dashboard_search_milliseconds_sum | filter (service.instance.id == $instance) | rate 5m, 5m | group_by [], sum;\n  b = metric grafana_api_dashboard_search_milliseconds_count | filter (service.instance.id == $instance) | rate 5m, 5m | group_by [], sum;\njoin ((a / b)), a=0, b=0 | reduce 5m, min"
      }
    }
    chart {
      name   = "Dashboard Save Duration Quantiles"
      type   = "timeseries"
      rank   = 4
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_api_dashboard_search_milliseconds_p50 | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_api_dashboard_search_milliseconds_p90 | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric grafana_api_dashboard_search_milliseconds_p99 | filter (service.instance.id == $instance) | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Dashboard Save Duration Avg (5 min)"
      type   = "timeseries"
      rank   = 5
      x_pos  = 16
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric grafana_api_dashboard_save_milliseconds_sum | filter (service.instance.id == $instance) | rate 5m, 5m | group_by [], sum;\n  b = metric grafana_api_dashboard_save_milliseconds_count | filter (service.instance.id == $instance) | rate 5m, 5m | group_by [], sum;\njoin ((a / b)), a=0, b=0 | reduce 5m, min"
      }
    }
  }

  template_variable {
    name                     = "instance"
    default_values           = []
    suggestion_attribute_key = "service.instance.id"
  }
}
