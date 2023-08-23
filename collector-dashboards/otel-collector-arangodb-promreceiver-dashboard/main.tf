terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_arangodb_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry ArangoDB Dashboard"
  dashboard_description = "Monitor ArangoDB metrics with this summary dashboard."

  chart {
    name = "Server Statistics Idle Percent"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric arangodb_server_statistics_idle_percent | rate | group_by [], sum"
    }
  }

  chart {
    name = "Server Statistics System Percent"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric arangodb_server_statistics_system_percent | rate | group_by [], sum"
    }
  }

  chart {
    name = "Server Statistics User Percent"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric arangodb_server_statistics_user_percent | rate | group_by [], sum"
    }
  }

  chart {
    name = "Server Statistics Physical Memory"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric arangodb_server_statistics_physical_memory | rate | group_by [], sum"
    }
  }
  
  chart {
    name = "Process Statistics Resident Memory"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric arangodb_process_statistics_virtual_memory_size | rate | group_by [], sum"
    }
  }

  chart {
    name = "File Descriptors"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric arangodb_file_descriptors_current | rate | group_by [], sum"
    }
  }

  chart {
    name = "Server Uptime"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric arangodb_server_statistics_server_uptime_total | rate | group_by [], sum"
    }
  }

  chart {
    name = "Heartbeat Failures"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric arangodb_heartbeat_failures_total | rate | group_by [], sum"
    }
  }

}