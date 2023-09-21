terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}


resource "lightstep_dashboard" "otel_collector_ibmmq_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry IBMMQ Integration"
  dashboard_description = "Monitoring OpenTelemetry Collector - IBMMQ Metrics"

  chart {
    name = "Manager Commit"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_commit | rate | group_by [], sum"
    }

  }

  chart {
    name = "Manager CPU Load Fifteen Minute Average Percentage"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ibmmq_qmgr_cpu_load_fifteen_minute_average_percentage | latest | group_by [], sum
EOT 
    }

  }

  chart {
    name = "Manager CPU Load Five Minute Average Percentage"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_cpu_load_five_minute_average_percentage | rate | group_by [], sum"
    }

  }

  chart {
    name = "Manager CPU Load One Minute Average Percentage"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_cpu_load_one_minute_average_percentage | rate | group_by [], sum"
    }

  }

  chart {
    name = "CPU Time Percentage"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_user_cpu_time_percentage | rate | group_by [], sum"
    }

  }

  chart {
    name = "CPU Time Estimate for Queue Manager Percentage"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_user_cpu_time_estimate_for_queue_manager_percentage | rate | group_by [], sum"
    }

  }

  chart {
    name = "CPU Time Estimate for Queue Manager Percentage"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_trace_file_system_in_use_bytes | rate | group_by [], sum"
    }

  }

  chart {
    name = "CPU Time Estimate for Queue Manager Percentage"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_trace_file_system_free_space_percentage | rate | group_by [], sum"
    }

  }

  chart {
    name = "CPU Time Estimate for Queue Manager Percentage"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_topic_put_bytes | rate | group_by [], sum"
    }

  }

  chart {
    name = "CPU Time Estimate for Queue Manager Percentage"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_topic_mqput_mqput1 | rate | group_by [], sum"
    }

  }

  chart {
    name = "CPU Time Estimate for Queue Manager Percentage"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_system_cpu_time_percentage | rate | group_by [], sum"
    }

  }

  chart {
    name = "CPU Time Estimate for Queue Manager Percentage"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_system_cpu_time_estimate_for_queue_manager_percentage | rate | group_by [], sum"
    }

  }

  chart {
    name = "Rollback Count"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_rollback | rate | group_by [], sum"
    }

  }

  chart {
    name = "Ram Usage Estimate for Queue Manager Bytes"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_ram_usage_estimate_for_queue_manager_bytes | rate | group_by [], sum"
    }

  }

  chart {
    name = "Queue Manager Ram Free Percentage"
    rank = "14"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_ram_free_percentage | rate | group_by [], sum"
    }

  }

  chart {
    name = "Queue Manager Managed File System Free Space Percentage"
    rank = "15"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_queue_manager_file_system_in_use_bytes | rate | group_by [], sum"
    }

  }

  chart {
    name = "Queue Manager Purged Queue Count"
    rank = "16"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_purged_queue | rate | group_by [], sum"
    }

  }

  chart {
    name = "Queue Manager Purged Queue Count"
    rank = "17"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ibmmq_qmgr_purged_queue | rate | group_by [], sum"
    }

  }

}
