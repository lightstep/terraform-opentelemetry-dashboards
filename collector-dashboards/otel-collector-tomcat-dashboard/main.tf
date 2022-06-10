terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.60.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_tomcat_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "OpenTelemetry / Apache Tomcat Integration"

  chart {
    name = "Requests"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "tomcat.request_count"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }
    }
  }

  chart {
    name = "Bytes"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "tomcat.traffic"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction", ]
      }
    }
  }

  chart {
    name = "Errors"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "tomcat.errors"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }
    }
  }

  chart {
    name = "Threads"
    rank = "3"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "area"
      hidden     = false

      metric              = "tomcat.threads"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["state", ]
      }
    }
  }

  chart {
    name = "Processing Time"
    rank = "4"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "tomcat.processing_time"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }
    }
  }

  chart {
    name = "JVM Memory used"
    rank = "5"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "jvm.memory.heap.used"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }
    }
  }
}
