terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.92.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_wildfly_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "JBoss Wildfly"
  dashboard_description = "Monitor JBoss Wildfly metrics with this summary dashboard."

  chart {
    name = "UP"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric up | latest | group_by [], sum"
    }
  }

  chart {
    name = "Undertow Processing Time"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric wildfly_undertow_processing_time | delta | group_by [], sum"
    }
  }

  chart {
    name = "Undertow Request Count"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric wildfly_undertow_request_count | delta | group_by [], sum"
    }
  }

  chart {
    name = "Memory Bytes Used"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric jvm_memory_bytes_used | latest | group_by [], sum"
    }
  }

  chart {
    name = "Process CPU Seconds Total"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric process_cpu_seconds_total | rate | group_by [], sum"
    }
  }

  chart {
    name = "Process Resident Memory Bytes"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric process_resident_memory_bytes | latest | group_by [], sum"
    }
  }

  chart {
    name = "Committed Transactions"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric wildfly_transaction_committed_transactions | latest | group_by [], sum"
    }
  }

  chart {
    name = "Aborted Transactions"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric wildfly_transaction_aborted_transactions | latest | group_by [], sum"
    }
  }

  chart {
    name = "Datasource Pool Active Count"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric wildfly_datasource_pool_active_count | latest | group_by [], sum"
    }
  }

  chart {
    name = "Datasource Pool Wait Count"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric wildfly_datasource_pool_wait_count | latest | group_by [], sum"
    }
  }
}
