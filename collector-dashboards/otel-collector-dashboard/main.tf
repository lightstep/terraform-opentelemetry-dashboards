terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.60.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry Collector"

    chart {
      name = "Instance count"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "otelcol_process_uptime"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = ["service_instance_id"]
        }
        # TODO: add description: Uptime of the process
      }
    }

    chart {
      name = "CPU"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display = "line"
        hidden = false

        metric = "otelcol_process_cpu_seconds"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = ["service_instance_id"]
        }
        # TODO: add description: Total CPU user and system time in seconds
        # TODO: add units: Seconds
      }
    }

    chart {
      name = "Memory RSS"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display = "line"
        hidden = false

        metric = "otelcol_process_memory_rss"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["service_instance_id"]
        }
        # TODO: add description: Total physical memory (resident set size)
        # TODO: add units: Bytes
      }
    }

    chart {
      name = "Receiver: Received spans"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "otelcol_receiver_accepted_spans"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = ["receiver"]
        }
        # TODO: add description: Number of spans successfully pushed into the pipeline.
      }
    }

    chart {
      name = "Receiver: Received metric points"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "otelcol_receiver_accepted_metric_points"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = ["receiver"]
        }
        # TODO: add description: Number of metric points successfully pushed into the pipeline.
      }
    }

    chart {
      name = "Receiver: Received log records"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "otelcol_receiver_accepted_log_records"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = ["receiver"]
        }
        # TODO: add description: Number of log records successfully pushed into the pipeline.
      }
    }

    chart {
      name = "Receiver: Rejected spans"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "otelcol_receiver_refused_spans"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = ["receiver"]
        }
        # TODO: add description: Number of spans that could not be pushed into the pipeline.
      }
    }

    chart {
      name = "Receiver: Rejected metric points"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "otelcol_receiver_refused_metric_points"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = ["receiver"]
        }
        # TODO: add description: Number of metric points that could not be pushed into the pipeline.
      }
    }

    chart {
      name = "Receiver: Rejected log records"
      rank = "8"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "otelcol_receiver_refused_log_records"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = ["receiver"]
        }
        # TODO: add description: Number of log records that could not be pushed into the pipeline.
      }
    }

    chart {
      name = "Exporter: Sent spans"
      rank = "9"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "otelcol_exporter_sent_spans"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = ["exporter"]
        }
        # TODO: add description: Number of spans successfully sent to destination.
      }
    }

    chart {
      name = "Exporter: Sent metric points"
      rank = "10"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "otelcol_exporter_sent_metric_points"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = ["exporter"]
        }
        # TODO: add description: Number of metric points successfully sent to destination.
      }
    }

    chart {
      name = "Exporter: Sent log records"
      rank = "11"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "otelcol_exporter_sent_log_records"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = ["exporter"]
        }
        # TODO: add description: Number of log records successfully sent to destination.
      }
    }
    
}
