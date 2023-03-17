terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_tomcat_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Apache Tomcat Dashboard"
  dashboard_description = "Monitor Tomcat with this metric dashboard."

  chart {
    name = "Requests"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric tomcat.request_count | rate | group_by [], sum"
    }

  }

  chart {
    name = "Throughput (by direction)"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric tomcat.traffic | rate | group_by ["direction"], sum
EOT
    }

  }

  chart {
    name = "Errors"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric tomcat.errors | rate | group_by [], sum"
    }

  }

  chart {
    name = "Threads (by state)"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric tomcat.threads | latest | group_by ["state"], sum
EOT
    }

  }

  chart {
    name = "Processing Time"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric tomcat.processing_time | rate | group_by [], sum"
    }

  }

  chart {
    name = "JVM Memory used"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric jvm.memory.heap.used | latest | group_by [], sum"
    }

  }

}
