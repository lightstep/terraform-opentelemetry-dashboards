terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_pulsar_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry Pulsar & Dashboard"
  dashboard_description = "Monitor Pulsar and metrics with this summary dashboard."
  
  chart {
    name = "CPU Time Spent"
    rank = "0"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric process_cpu_seconds_total | rate | group_by [], sum"
    }
  }

  chart {
    name = "Resident Memory Size"
    rank = "1"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric process_resident_memory_bytes | rate | group_by [], sum"
    }
  }

  chart {
    name = "Virtual Memory Size"
    rank = "2"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric process_virtual_memory_bytes | rate | group_by [], sum"
    }
  }

  chart {
    name = "Process Max FDS"
    rank = "2"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric process_max_fds | rate | group_by [], sum"
    }
  }

  chart {
    name = "Process Open FDS"
    rank = "2"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric process_open_fds | rate | group_by [], sum"
    }
  }

  chart {
    name = "UP"
    rank = "2"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric up | rate | group_by [], sum"
    }
  }

  chart {
    name = "Active Connections"
    rank = "10"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_active_connections | rate | group_by [], sum"
    }
  }

  chart {
    name = "Broker Message Backlog"
    rank = "10"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_broker_msg_backlog | rate | group_by [], sum"
    }
  }

  chart {
    name = "Broker Incoming Message Rate"
    rank = "11"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_broker_rate_in | rate | group_by [], sum"
    }
  }

  chart {
    name = "Broker Outgoing Message Rate"
    rank = "12"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_broker_rate_out | rate | group_by [], sum"
    }
  }

  chart {
    name = "Broker Storage Size"
    rank = "13"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_broker_storage_size | rate | group_by [], sum"
    }
  }

  chart {
    name = "Broker Topics Count"
    rank = "14"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_broker_topics_count | rate | group_by [], sum"
    }
  }

  chart {
    name = "Message Backlog Across Topics"
    rank = "15"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_msg_backlog | rate | group_by [], sum"
    }
  }

  chart {
    name = "Producers Count"
    rank = "16"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_producers_count | rate | group_by [], sum"
    }
  }

  chart {
    name = "Consumers Count"
    rank = "17"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_consumers_count | rate | group_by [], sum"
    }
  }

  chart {
    name = "Total Incoming Bytes"
    rank = "18"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_in_bytes_total | rate | group_by [], sum"
    }
  }

  chart {
    name = "Total Outgoing Bytes"
    rank = "19"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_out_bytes_total | rate | group_by [], sum"
    }
  }

  chart {
    name = "Storage Read Rate"
    rank = "20"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_storage_read_rate | rate | group_by [], sum"
    }
  }

  chart {
    name = "Storage Write Rate"
    rank = "21"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_storage_write_rate | rate | group_by [], sum"
    }
  }

  chart {
    name = "Total Storage Size"
    rank = "22"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_storage_size | rate | group_by [], sum"
    }
  }

  chart {
    name = "Total Storage Size"
    rank = "22"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_storage_logical_size | rate | group_by [], sum"
    }
  }

  chart {
    name = "Subscription Backlog"
    rank = "30"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_subscription_back_log | rate | group_by [], sum"
    }
  }

  chart {
    name = "Subscription Consumers Count"
    rank = "31"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_subscription_consumers_count | rate | group_by [], sum"
    }
  }

  chart {
    name = "Subscription Message Rate Out"
    rank = "32"
    type = "timeseries"
    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pulsar_subscription_msg_rate_out | rate | group_by [], sum"
    }
  }

}
