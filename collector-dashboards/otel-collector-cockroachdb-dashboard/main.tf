terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_cockroachdb_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "CockroachDB - Overview"
  dashboard_description = "This dashboard provides a high-level overview of key CockroachDB metrics so you can ensure that your cluster is available, serving queries, and has sufficient resources to maintain high levels of performance."

  chart {
    name = "KV Pairs"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric syscount | reduce mean | group_by [], mean"
    }

  }

  chart {
    name = "Memory Usage Per SQL Statement"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric sql_stats_mem_max | delta | group_by [], sum | point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)"
    }

  }

  chart {
    name = "Capacity Used"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric capacity_used | reduce mean | group_by [], mean"
    }

  }

  chart {
    name = "Total Capacity"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric capacity | reduce mean | group_by [], mean"
    }

  }

  chart {
    name = "SQL UPDATE Count"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric sql_update_count | rate | group_by [], sum"
    }

  }

  chart {
    name = "SQL INSERT Count"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric sql_insert_count | rate | group_by [], sum"
    }

  }

  chart {
    name = "SQL DELETE Count"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric sql_delete_count | rate | group_by [], sum"
    }

  }

  chart {
    name = "SQL SELECT Count"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric sql_select_count | rate | group_by [], sum"
    }

  }

  chart {
    name = "Batch Request Latency"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric exec_latency | delta | group_by [], sum | point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)"
    }

  }

  chart {
    name = "SQL Connections"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric sql_conns | reduce mean | group_by [], mean"
    }

  }

  chart {
    name = "SQL Service Latency"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric sql_service_latency | delta | group_by [], sum | point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)"
    }

  }

  chart {
    name = "Capacity Available (%)"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "((a/b)*100)"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
with
  a = metric capacity_available | latest | group_by [], mean;
  b = metric capacity | reduce mean | group_by [], mean;
join (((a / b)*100)), a=0, b=0
EOT
    }

  }

  chart {
    name = "Current User CPU (%)"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric sys_cpu_user_percent | latest | group_by [], mean"
    }

  }

  chart {
    name = "System CPU (%)"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric sys_cpu_sys_percent | latest | group_by [], mean"
    }

  }

  chart {
    name = "Live Nodes"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric liveness_livenodes | reduce mean | group_by [], mean"
    }

  }

  chart {
    name = "Memory Usage Per SQL Session"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric sql_mem_sql_session_max | delta | group_by [], sum | point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)"
    }

  }

}