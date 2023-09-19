terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_hikaricp_dashboard" {
  project_name          = var.cloud_observability_project
  dashboard_name        = "HikariCP and System Metrics Dashboard"
  dashboard_description = "Monitor HikariCP and System Metrics."

  chart {
    name = "Total Connections"
    rank = "0"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric hikaricp_connections | rate | group_by [], sum"
    }
  }

  chart {
    name = "Active Connections"
    rank = "1"
    type = "timeseries"
    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = "metric hikaricp_connections_active | rate | group_by [], sum"
    }
  }

  chart {
    name = "Connection Creation Time"
    rank = "2"
    type = "timeseries"
    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = "metric hikaricp_connections_creation_seconds | rate | group_by [], sum"
    }
  }

  chart {
    name = "Idle Connections"
    rank = "3"
    type = "timeseries"
    query {
      query_name   = "d"
      display      = "line"
      hidden       = false
      query_string = "metric hikaricp_connections_idle | rate | group_by [], sum"
    }
  }

  chart {
    name = "Max Connections"
    rank = "4"
    type = "timeseries"
    query {
      query_name   = "e"
      display      = "line"
      hidden       = false
      query_string = "metric hikaricp_connections_max | rate | group_by [], sum"
    }
  }

  chart {
    name = "Pending Threads"
    rank = "5"
    type = "timeseries"
    query {
      query_name   = "f"
      display      = "line"
      hidden       = false
      query_string = "metric hikaricp_connections_pending | rate | group_by [], sum"
    }
  }

   chart {
    name = "Min Connections"
    rank = "6"
    type = "timeseries"
    query {
      query_name   = "g"
      display      = "line"
      hidden       = false
      query_string = "metric hikaricp_connections_min | rate | group_by [], sum"
    }
  }

  chart {
    name = "Connection Timeout Total Count"
    rank = "7"
    type = "timeseries"
    query {
      query_name   = "h"
      display      = "line"
      hidden       = false
      query_string = "metric hikaricp_connections_timeout_total | rate | group_by [], sum"
    }
  }

  chart {
    name = "Connection Usage Time"
    rank = "8"
    type = "timeseries"
    query {
      query_name   = "i"
      display      = "line"
      hidden       = false
      query_string = "metric hikaricp_connections_usage_seconds | rate | group_by [], sum"
    }
  }

  chart {
    name = "System CPU Usage"
    rank = "9"
    type = "timeseries"
    query {
      query_name   = "j"
      display      = "line"
      hidden       = false
      query_string = "metric system_cpu_usage | rate | group_by [], sum"
    }
  }

  chart {
    name = "System CPU Count"
    rank = "10"
    type = "timeseries"
    query {
      query_name   = "k"
      display      = "line"
      hidden       = false
      query_string = "metric system_cpu_count | rate | group_by [], sum"
    }
  }

  chart {
    name = "JVM Memory Used"
    rank = "11"
    type = "timeseries"
    query {
      query_name   = "l"
      display      = "line"
      hidden       = false
      query_string = "metric jvm_memory_used_bytes | rate | group_by [], sum"
    }
  }

  chart {
    name = "JVM Threads Live"
    rank = "12"
    type = "timeseries"
    query {
      query_name   = "m"
      display      = "line"
      hidden       = false
      query_string = "metric jvm_threads_live_threads | rate | group_by [], sum"
    }
  }

 chart {
    name = "JVM Buffer Count Buffers"
    rank = "13"
    type = "timeseries"
    query {
      query_name   = "n"
      display      = "line"
      hidden       = false
      query_string = "metric jvm_buffer_count_buffers | rate | group_by [], sum"
    }
  }

  chart {
    name = "JVM Buffer Memory Used Bytes"
    rank = "14"
    type = "timeseries"
    query {
      query_name   = "o"
      display      = "line"
      hidden       = false
      query_string = "metric jvm_buffer_memory_used_bytes | rate | group_by [], sum"
    }
  }

  chart {
    name = "JVM Buffer Total Capacity Bytes"
    rank = "15"
    type = "timeseries"
    query {
      query_name   = "p"
      display      = "line"
      hidden       = false
      query_string = "metric jvm_buffer_total_capacity_bytes | rate | group_by [], sum"
    }
  }

  chart {
    name = "Process CPU Usage"
    rank = "16"
    type = "timeseries"
    query {
      query_name   = "s"
      display      = "line"
      hidden       = false
      query_string = "metric process_cpu_usage | rate | group_by [], sum"
    }
  }

  chart {
    name = "Process Uptime Seconds"
    rank = "17"
    type = "timeseries"
    query {
      query_name   = "t"
      display      = "line"
      hidden       = false
      query_string = "metric process_uptime_seconds | rate | group_by [], sum"
    }
  }

  chart {
    name = "System Load Average 1m"
    rank = "18"
    type = "timeseries"
    query {
      query_name   = "u"
      display      = "line"
      hidden       = false
      query_string = "metric system_load_average_1m | rate | group_by [], sum"
    }
  }

  chart {
    name = "Tomcat Active Current Sessions"
    rank = "21"
    type = "timeseries"
    query {
      query_name   = "v"
      display      = "line"
      hidden       = false
      query_string = "metric tomcat_sessions_active_current_sessions | rate | group_by [], sum"
    }
  }

  chart {
    name = "Tomcat Max Active Sessions"
    rank = "22"
    type = "timeseries"
    query {
      query_name   = "w"
      display      = "line"
      hidden       = false
      query_string = "metric tomcat_sessions_active_max_sessions | rate | group_by [], sum"
    }
  }

  chart {
    name = "Tomcat Sessions Alive Max Seconds"
    rank = "23"
    type = "timeseries"
    query {
      query_name   = "x"
      display      = "line"
      hidden       = false
      query_string = "metric tomcat_sessions_alive_max_seconds | rate | group_by [], sum"
    }
  }

  chart {
    name = "Tomcat Sessions Created Total"
    rank = "24"
    type = "timeseries"
    query {
      query_name   = "y"
      display      = "line"
      hidden       = false
      query_string = "metric tomcat_sessions_created_sessions_total | rate | group_by [], sum"
    }
  }

  chart {
    name = "Tomcat Sessions Expired Total"
    rank = "25"
    type = "timeseries"
    query {
      query_name   = "z"
      display      = "line"
      hidden       = false
      query_string = "metric tomcat_sessions_expired_sessions_total | rate | group_by [], sum"
    }
  }

  chart {
    name = "System CPU Count"
    rank = "26"
    type = "timeseries"
    query {
      query_name   = "ab"
      display      = "line"
      hidden       = false
      query_string = "metric system_cpu_count | rate | group_by [], sum"
    }
  }

  chart {
    name = "System CPU Usage"
    rank = "27"
    type = "timeseries"
    query {
      query_name   = "ac"
      display      = "line"
      hidden       = false
      query_string = "metric system_cpu_usage | rate | group_by [], sum"
    }
  }

}

