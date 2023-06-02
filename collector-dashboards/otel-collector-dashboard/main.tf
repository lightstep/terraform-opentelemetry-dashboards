terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.76.0"
    }
  }
  required_version = ">= v1.0.11"
}

locals {
  # Addons
  prometheus_addon = "prometheus"
}

resource "lightstep_dashboard" "otel_collector_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry Collector"
  dashboard_description = "OTel Collector Dashboard"

  chart {
    name = "Collector Uptime %"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric otelcol_process_uptime
| rate 1s
| group_by [collector_name,job,service_instance_id], sum
| * 100.00
EOT
    }

  }

  chart {
    name = "Data Points Accepted & Rejected"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_receiver_accepted_metric_points
| delta
| group_by [receiver, collector_name], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_receiver_accepted_spans
| delta
| group_by [receiver, collector_name], sum
EOT
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_receiver_refused_metric_points
| delta
| group_by [receiver, collector_name], sum
EOT
    }

    query {
      query_name   = "d"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_receiver_refused_spans
| delta
| group_by [receiver, collector_name], sum
EOT
    }
  }

  chart {
    name = "Processor Refused & Dropped"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "dropped metrics"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_processor_dropped_metric_points
| delta
| group_by [processor, collector_name], sum
EOT
    }

    query {
      query_name   = "dropped spans"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_processor_dropped_spans
| delta
| group_by [exporter, collector_name], sum
EOT
    }

    query {
      query_name   = "refused metrics"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_processor_refused_metric_points
| delta
| group_by [processor, collector_name], sum
EOT
    }

    query {
      query_name   = "refused spans"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_processor_refused_spans
| delta
| group_by [exporter, collector_name], sum
EOT
    }
  }

  chart {
    name = "Exporter Sent & Failed"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_exporter_sent_metric_points
| delta
| group_by [exporter, collector_name], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_exporter_sent_spans
| delta
| group_by [exporter, collector_name], sum
EOT
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_exporter_send_failed_metric_points
| delta
| group_by [exporter, collector_name], sum
EOT
    }

    query {
      query_name   = "d"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_exporter_send_failed_spans
| delta
| group_by [exporter, collector_name], sum
EOT
    }
  }

  chart {
    name = "Batch Send Size"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_processor_batch_batch_send_size
| delta
| group_by [processor, collector_name], sum
| point percentile(value, 99)
EOT
    }

  }

  chart {
    name = "Exporter Queue Size"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric otelcol_exporter_queue_size
| latest
| group_by [exporter, collector_name], sum

EOT
    }

  }

  chart {
    name = "Hourly Active Time Series"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric lightstep.hourly_active_time_series
| delta 1h
| group_by [service.name], sum
EOT
    }
  }
}
