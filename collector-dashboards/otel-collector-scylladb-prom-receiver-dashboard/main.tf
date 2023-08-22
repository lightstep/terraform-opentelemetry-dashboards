terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_scylladb_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry ScyllaDB Dashboard"
  dashboard_description = "Monitor ScyllaDB metrics with this summary dashboard."

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
    name = "Scylla Query Requests"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric scylla_transport_query_requests | rate | group_by [], sum"
    }
  }

  chart {
    name = "CQL Connections"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric scylla_transport_cql_connections | rate | group_by [], sum"
    }
  }

  chart {
    name = "Total Incoming Bytes"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric scylla_streaming_total_incoming_bytes | rate | group_by [], sum"
    }
  }

  chart {
    name = "Total Incoming Bytes"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric scylla_streaming_total_incoming_bytes | rate | group_by [], sum"
    }
  }

  chart {
    name = "Total Outgoing Bytes"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric scylla_streaming_total_outgoing_bytes | rate | group_by [], sum"
    }
  }

}