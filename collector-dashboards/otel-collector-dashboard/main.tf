terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

locals {
}

resource "lightstep_dashboard" "otel_collector_dashboard" {
  project_name          = var.cloud_observability_project
  dashboard_name        = "OpenTelemetry Collector"
  dashboard_description = "OTel Collector Dashboard"

  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"

    chart {
      name   = "Collector Up %"
      type   = "timeseries"
      rank   = 1
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric otelcol_process_uptime | filter ((collector_name == $collector_name) && (service_name == $service_name)) | rate 1s | group_by [\"collector_name\", \"job\", \"service_instance_id\"], sum | * 100.00"
      }
    }
    chart {
      name   = "Data Points Accepted & Rejected"
      type   = "timeseries"
      rank   = 2
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_accepted_metric_points | filter (((receiver == $receiver) && (collector_name == $collector_name)) && (service_name == $service_name)) | delta | group_by [\"receiver\", \"collector_name\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_accepted_spans | filter (((receiver == $receiver) && (collector_name == $collector_name)) && (service_name == $service_name)) | delta | group_by [\"receiver\", \"collector_name\"], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_refused_metric_points | filter (((receiver == $receiver) && (collector_name == $collector_name)) && (service_name == $service_name)) | delta | group_by [\"receiver\", \"collector_name\"], sum"
      }
      query {
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_refused_spans | filter (((receiver == $receiver) && (collector_name == $collector_name)) && (service_name == $service_name)) | delta | group_by [\"receiver\", \"collector_name\"], sum"
      }
    }
    chart {
      name   = "Processor Refused & Dropped"
      type   = "timeseries"
      rank   = 3
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_dropped_metric_points | filter (((processor == $processor) && (collector_name == $collector_name)) && (service_name == $service_name)) | delta | group_by [\"processor\", \"collector_name\"], sum"
      }
    }
    chart {
      name   = "Exporter Sent & Failed"
      type   = "timeseries"
      rank   = 4
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_sent_metric_points | filter (((exporter == $exporter) && (collector_name == $collector_name)) && (service_name == $service_name)) | delta | group_by [\"exporter\", \"collector_name\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_sent_spans | filter (((exporter == $exporter) && (collector_name == $collector_name)) && (service_name == $service_name)) | delta | group_by [\"exporter\", \"collector_name\"], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_send_failed_metric_points | filter (((exporter == $exporter) && (collector_name == $collector_name)) && (service_name == $service_name)) | delta | group_by [\"exporter\", \"collector_name\"], sum"
      }
      query {
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_send_failed_spans | filter (((exporter == $exporter) && (collector_name == $collector_name)) && (service_name == $service_name)) | delta | group_by [\"exporter\", \"collector_name\"], sum"
      }
    }
    chart {
      name   = "Batch Send Size"
      type   = "timeseries"
      rank   = 5
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_batch_batch_send_size | filter (((processor == $processor) && (collector_name == $collector_name)) && (service_name == $service_name)) | delta | group_by [\"processor\", \"collector_name\"], sum | point percentile(value, 99.0)"
      }
    }
    chart {
      name   = "Exporter Queue Size"
      type   = "timeseries"
      rank   = 6
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_queue_size | filter (((exporter == $exporter) && (collector_name == $collector_name)) && (service_name == $service_name)) | latest | group_by [\"exporter\", \"collector_name\"], sum"
      }
    }
    chart {
      name   = "Hourly Active Time Series"
      type   = "timeseries"
      rank   = 7
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric lightstep.hourly_active_time_series\n| delta 1h\n| group_by [service.name], sum\n"
      }
    }
  }

  template_variable {
    name                     = "service_name"
    default_values           = []
    suggestion_attribute_key = "service_name"
  }
  template_variable {
    name                     = "collector_name"
    default_values           = []
    suggestion_attribute_key = "collector_name"
  }
  template_variable {
    name                     = "processor"
    default_values           = []
    suggestion_attribute_key = "processor"
  }
  template_variable {
    name                     = "receiver"
    default_values           = []
    suggestion_attribute_key = "receiver"
  }
  template_variable {
    name                     = "exporter"
    default_values           = []
    suggestion_attribute_key = "exporter"
  }
}