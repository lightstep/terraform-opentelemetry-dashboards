terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.1"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_dashboard" {
  dashboard_name        = "K8s OpenTelemetry Collectors"
  project_name          = var.lightstep_project
  dashboard_description = "A top down dashboard for monitoring the health of your OpenTelemetry Collectors running in kubernetes"

  group {
    rank            = 0
    title           = "Overview"
    visibility_type = "explicit"

    chart {
      name        = "Metric Points Overview"
      description = "The rate in which metric points flow through the collector"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_failed_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_sent_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_dropped_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_refused_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "e"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_accepted_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "f"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_accepted_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "g"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_refused_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Spans Overview"
      description = "The rate in which spans flow through the collector"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_failed_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_sent_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_accepted_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_refused_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "e"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_dropped_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "f"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_accepted_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "g"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_refused_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Logs Overview"
      description = "The rate in which logs flow through the collector"
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_failed_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_sent_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_accepted_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_refused_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "e"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_dropped_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "f"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_accepted_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "g"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_refused_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Telemetry Refused By Receiver"
      description = "The rate in which the receivers refuse metric points, spans, and log records due to errors"
      type        = "timeseries"
      rank        = 3
      x_pos       = 0
      y_pos       = 14
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_refused_metric_points | filter (((((\"k8s.namespace.name\" == $namespace) && (\"k8s.cluster.name\" == $cluster)) && (\"service.name\" == $service_name)) && (\"k8s.pod.uid\" == $pod_uid)) && (\"k8s.pod.name\" == $pod)) | rate | group_by [\"receiver\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_refused_spans | filter (((((\"k8s.namespace.name\" == $namespace) && (\"k8s.cluster.name\" == $cluster)) && (\"service.name\" == $service_name)) && (\"k8s.pod.uid\" == $pod_uid)) && (\"k8s.pod.name\" == $pod)) | rate | group_by [\"receiver\"], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_refused_log_records | filter (((((\"k8s.namespace.name\" == $namespace) && (\"k8s.cluster.name\" == $cluster)) && (\"service.name\" == $service_name)) && (\"k8s.pod.uid\" == $pod_uid)) && (\"k8s.pod.name\" == $pod)) | rate | group_by [\"receiver\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Telemetry Dropped And Refused By Processor"
      description = "The rate in which metric points, spans, and log records are refused (rejected) or dropped by a processor"
      type        = "timeseries"
      rank        = 4
      x_pos       = 16
      y_pos       = 14
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_dropped_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"processor\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_dropped_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"processor\"], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_dropped_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"processor\"], sum"
      }
      query {
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_refused_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"processor\"], sum"
      }
      query {
        query_name   = "e"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_refused_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"processor\"], sum"
      }
      query {
        query_name   = "f"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_refused_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"processor\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Telemetry Failures By Exporter"
      description = "The rate in which metric points, spans, and log records failed to be sent to a destination including CloudObs"
      type        = "timeseries"
      rank        = 5
      x_pos       = 32
      y_pos       = 14
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_failed_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"exporter\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_failed_spans_total | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"exporter\"], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_failed_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"exporter\"], sum"
      }
      query {
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_failed_metric_points_total | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"exporter\"], sum"
      }
      query {
        query_name   = "e"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_failed_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"exporter\"], sum"
      }
      query {
        query_name   = "f"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_send_failed_spans | filter (((((\"k8s.pod.name\" == $pod) && (\"k8s.pod.uid\" == $pod_uid)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "g"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_send_failed_metric_points | filter (((((\"k8s.pod.name\" == $pod) && (\"k8s.pod.uid\" == $pod_uid)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      query {
        query_name   = "h"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_send_failed_log_records | filter (((((\"k8s.pod.name\" == $pod) && (\"k8s.pod.uid\" == $pod_uid)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [], sum"
      }
      subtitle = ""
    }
    chart {
      name        = "Number of Pods Per Pool"
      description = "Count of total Kubernetes pods per pool"
      type        = "timeseries"
      rank        = 6
      x_pos       = 0
      y_pos       = 22
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric k8s.pod.phase | filter ((((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) && (\"service.name\" =~ \".*collector\")) | latest | group_by [\"service.name\"], count_nonzero"
      }

      subtitle = ""
    }
    chart {
      name        = "Total Pods Per Pool"
      description = "Count of total Kubernetes pods per pool"
      type        = "timeseries"
      rank        = 7
      x_pos       = 16
      y_pos       = 22
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric k8s.pod.phase | filter ((((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) && (\"service.name\" =~ \".*collector\")) | latest 30s | group_by [\"service.name\"], count_nonzero"
      }

      subtitle = ""
    }
    chart {
      name        = "Pods In An Unhealthy Phase"
      description = "Count of pods in the Failed or Unknown phase. If the chart has \"No data found\", this likely means there has not been a pod in an unhealthy phase so far."
      type        = "timeseries"
      rank        = 8
      x_pos       = 32
      y_pos       = 22
      width       = 16
      height      = 8

      query {
        query_name   = "b"
        display      = "bar"
        hidden       = false
        query_string = "metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | point_filter value == 4 || value == 5 | latest | group_by [\"service.name\"], count_nonzero"
      }

      subtitle = ""
    }

    text_panel {
      name   = "About this dashboard"
      x_pos  = 0
      y_pos  = 0
      width  = 48
      height = 6
      text   = "This dashboard monitors the health of your [OpenTelemetry Collectors](https://docs.lightstep.com/docs/collector-home-page) that are running in Kubernetes. It works best when collectors are provisioned with the [otel-cloud-stack chart](https://docs.lightstep.com/docs/quick-start-infra-otel-first#send-kubernetes-metrics-to-cloud-observability).\n\nUse template variables to filter data. To filter to specific collectors, use the `$service_name` template variable. Collectors running in k8s have a service name that ends with \"collector\". Filter to individual collector pods with the `$pod` or `$pod_uid` template variables.\n\nIf the charts indicate \"No data found\" you may not be sending metrics from the collectors for that chart."
    }
  }
  group {
    rank            = 1
    title           = "Receivers"
    visibility_type = "explicit"

    chart {
      name        = "Rate of Accepted Metric Points"
      description = "Rate of metrics that were successfully reported to collectors vs refused by the collector"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_accepted_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"receiver\", \"service.name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Accepted Spans"
      description = "Rate of spans successfully pushed into the pipeline"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_accepted_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"receiver\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Accepted Log Records"
      description = "Rate of log records successfully pushed into the pipeline"
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_accepted_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"receiver\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Refused Metric Points"
      description = "Rate of metric points that were not pushed into the pipeline"
      type        = "timeseries"
      rank        = 3
      x_pos       = 0
      y_pos       = 14
      width       = 16
      height      = 8

      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_refused_metric_points | filter (((((\"service.name\" == $service_name) && (\"k8s.namespace.name\" == $namespace)) && (\"k8s.pod.name\" == $pod)) && (\"k8s.pod.uid\" == $pod_uid)) && (\"k8s.cluster.name\" == $cluster)) | rate | group_by [\"receiver\", \"service.name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Refused Spans"
      description = "Rate of spans that could not be pushed into the pipeline"
      type        = "timeseries"
      rank        = 4
      x_pos       = 16
      y_pos       = 14
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_refused_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"receiver\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Refused Log Records"
      description = "Rate of log records that could not be pushed into the pipeline"
      type        = "timeseries"
      rank        = 5
      x_pos       = 32
      y_pos       = 14
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_receiver_refused_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"receiver\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Scraped Metric Points"
      description = "Rate of Metric Points Successfully Scraped. These may include prometheus scraped metrics: https://opentelemetry.io/docs/collector/scaling/#scaling-the-scrapers"
      type        = "timeseries"
      rank        = 6
      x_pos       = 0
      y_pos       = 22
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_scraper_scraped_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"receiver\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Errored Scraper Metric Points"
      description = "Rate of metric points that were unable to be scraped. These may include prometheus scraped metrics: https://opentelemetry.io/docs/collector/scaling/#scaling-the-scrapers"
      type        = "timeseries"
      rank        = 7
      x_pos       = 16
      y_pos       = 22
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_scraper_errored_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"receiver\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Metric Points Scrape Error Rate [%]"
      description = "The error rate of scraping metric points per collector pool. These may include prometheus scraped metrics: https://opentelemetry.io/docs/collector/scaling/#scaling-the-scrapers"
      type        = "timeseries"
      rank        = 8
      x_pos       = 32
      y_pos       = 22
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n  errors = metric otelcol_scraper_errored_metric_points | filter k8s.pod.uid == $pod_uid && k8s.pod.name == $pod && k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && service.name == $service_name | rate | group_by [\"service.name\", \"receiver\"], sum;\n  successes = metric otelcol_scraper_scraped_metric_points | filter k8s.pod.uid == $pod_uid && k8s.pod.name == $pod && k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && service.name == $service_name | rate | group_by [\"service.name\", \"receiver\"], sum;\njoin errors * 100.0 / (errors + successes), errors=0, successes=1"
      }

      subtitle = ""
    }

    text_panel {
      name   = "About This Section"
      x_pos  = 0
      y_pos  = 0
      width  = 48
      height = 6
      text   = "Monitor the state of your Collector [Receivers](https://github.com/open-telemetry/opentelemetry-collector/blob/main/receiver/README.md) that accept or scrape telemetry data for collection.\n\nSome receivers like the [_hostmetrics_](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/hostmetricsreceiver/README.md) and [_prometheus_](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/prometheusreceiver/README.md) receivers actively obtain telemetry data to place in the collection pipeline. The prometheus receiver can hit scaling issues if there are, say, thousands of prometheus endpoints to scrape. For guidance on scaling and sharding scrapers, see https://opentelemetry.io/docs/collector/scaling/#scaling-the-scrapers\n\nFor all other information on scaling the receiver, see https://opentelemetry.io/docs/collector/scaling/#how-to-scale"
    }
  }
  group {
    rank            = 2
    title           = "Processors"
    visibility_type = "explicit"

    chart {
      name        = "Dropped Metric Points"
      description = "Number of metric points that were dropped"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_dropped_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"processor\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Dropped Spans"
      description = "Number of spans that were dropped"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_dropped_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"processor\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Dropped Log Records"
      description = "Number of logs that were dropped"
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_dropped_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"processor\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Refused Metric Points"
      description = "Number of metric points that were rejected by the next component in the pipeline"
      type        = "timeseries"
      rank        = 3
      x_pos       = 0
      y_pos       = 14
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_refused_metric_points | filter (((((\"k8s.namespace.name\" == $namespace) && (\"k8s.pod.name\" == $pod)) && (\"k8s.pod.uid\" == $pod_uid)) && (\"service_name\" == $service_name)) && (\"k8s.cluster.name\" == $cluster)) | rate | group_by [\"service.name\", \"processor\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Refused Spans"
      description = "Number of Spans that were rejected by the next component in the pipeline."
      type        = "timeseries"
      rank        = 4
      x_pos       = 16
      y_pos       = 14
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_refused_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"processor\", \"service.name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Refused Log Records"
      description = "Number of log records that were rejected by the next component in the pipeline."
      type        = "timeseries"
      rank        = 5
      x_pos       = 32
      y_pos       = 14
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_refused_log_records | filter (((((\"service.name\" == $service_name) && (\"k8s.pod.uid\" == $pod_uid)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"k8s.pod.name\" == $pod)) | rate | group_by [\"service.name\", \"processor\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Accepted Metric Points"
      description = "Number of metric points successfully pushed into the next component in the pipeline."
      type        = "timeseries"
      rank        = 6
      x_pos       = 0
      y_pos       = 22
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_accepted_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"processor\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Accepted Spans"
      description = "Number of spans successfully pushed into the next component in the pipeline"
      type        = "timeseries"
      rank        = 7
      x_pos       = 16
      y_pos       = 22
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_accepted_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"processor\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Rate of Accepted Log Records"
      description = "Number of logs successfully pushed into the next component in the pipeline."
      type        = "timeseries"
      rank        = 8
      x_pos       = 32
      y_pos       = 22
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_accepted_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"processor\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "p99 Processor Batch Send Size"
      description = " 99th percentile of the size of batches (in count of metric points, spans, or logs) in the [batch processor](https://github.com/open-telemetry/opentelemetry-collector/blob/main/processor/batchprocessor/README.md). This shows the upper end of batch payloads in count of items that will be exported. The batch processor accepts spans, metrics, or logs to better compress the data and send it over fewer outgoing connections."
      type        = "timeseries"
      rank        = 9
      x_pos       = 0
      y_pos       = 30
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_batch_batch_send_size | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | delta | group_by [\"processor\", \"service.name\"], sum | point percentile(value, 99.0)"
      }

      subtitle = ""
    }
    chart {
      name        = "p99 Processor Batch Send Size in Bytes"
      description = "99th percentile of the size of batches (in bytes) in the [batch processor](https://github.com/open-telemetry/opentelemetry-collector/blob/main/processor/batchprocessor/README.md). This shows the upper end of batch payloads in byte size that will be exported. The batch processor accepts spans, metrics, or logs to better compress the data and send it over fewer outgoing connections."
      type        = "timeseries"
      rank        = 10
      x_pos       = 16
      y_pos       = 30
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_batch_batch_send_size_bytes | filter k8s.pod.uid == $pod_uid && k8s.pod.name == $pod && k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && \"service.name\" == $service_name | delta | group_by [\"processor\", \"service.name\"], sum | point percentile(value, 99.0)"
      }

      subtitle = ""
    }
    chart {
      name        = "Batch Processor Triggers"
      description = "The [batch processor](https://github.com/open-telemetry/opentelemetry-collector/blob/main/processor/batchprocessor/README.md) is triggered to send a batch when it exceeds their target size or after a timeout, whichever happens first. This chart shows the balance between size and timeout triggers. Adjust the batch processor by configuring `send_batch_size`, `send_batch_max_size`, and `timeout`."
      type        = "timeseries"
      rank        = 11
      x_pos       = 32
      y_pos       = 30
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_batch_timeout_trigger_send | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | delta | group_by [\"processor\", \"service.name\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_processor_batch_batch_size_trigger_send | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | delta | group_by [\"processor\", \"service.name\"], sum"
      }

      subtitle = ""
    }

    text_panel {
      name   = "About This Section"
      x_pos  = 0
      y_pos  = 0
      width  = 48
      height = 6
      text   = "Monitor the state of your Collector [Processors](https://github.com/open-telemetry/opentelemetry-collector/blob/main/processor/README.md) that operate on received telemetry before it is exported. Processors are optional components, and if your collectors do not include any processors, these charts will be empty.\n\nIn the case of the [_memory_limiter_](https://github.com/open-telemetry/opentelemetry-collector/blob/main/processor/memorylimiterprocessor/README.md) processor, new telemetry data will be blocked from passing through the pipeline by the _memory_limiter_, and show up in the Refused Metric Points, Spans, or Log Records charts. If telemetry is regularly refused due to memory limits, you likely need to scale up your cluster.\n\nFor more information, see https://opentelemetry.io/docs/collector/scaling/#when-to-scale "
    }
  }
  group {
    rank            = 3
    title           = "Exporters"
    visibility_type = "explicit"

    chart {
      name        = "Sent Metric Points"
      description = "Number of metric points sent to the destination, including Cloud Observability"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 5
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_sent_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"exporter\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Sent Spans"
      description = "Number of spans successfully sent to destination, including Cloud Observability"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 5
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_sent_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"exporter\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Sent Log Records"
      description = "Number of log records successfully sent to destination, including Cloud Observability"
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 5
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_sent_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"exporter\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Failed Enqueue Metric Points"
      description = "Number of metric points that failed to be sent to destination, including Cloud Observability"
      type        = "timeseries"
      rank        = 3
      x_pos       = 0
      y_pos       = 13
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_failed_metric_points | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"exporter\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Failed Enqueue Spans"
      description = "Number of spans in failed attempts to send to destination, including Cloud Observability"
      type        = "timeseries"
      rank        = 4
      x_pos       = 16
      y_pos       = 13
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_failed_spans | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"exporter\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Failed Enqueue Log Records"
      description = "Number of log records in failed attempts to send to destination, including Cloud Observability"
      type        = "timeseries"
      rank        = 5
      x_pos       = 32
      y_pos       = 13
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_enqueue_failed_log_records | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"exporter\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Collector Exporter Queue Size"
      description = "Current size of the retry queue"
      type        = "timeseries"
      rank        = 6
      x_pos       = 0
      y_pos       = 29
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_queue_size | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | latest | group_by [\"exporter\", \"service.name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Queue Capacity (in batches)"
      description = "Indicates the capacity of the retry queue (in batches) per collector pool"
      type        = "timeseries"
      rank        = 7
      x_pos       = 16
      y_pos       = 29
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_queue_capacity | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | latest 1m | group_by [\"service.name\", \"exporter\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Queue Usage [%]"
      description = "Indicates the usage of the in-memory telemetry exporter queue, relative to queue capacity per collector pool. If the queue usage reaches 100% capacity, the collector will reject data. The collector queues telemetry while waiting for a worker to be ready to send the telemetry"
      type        = "timeseries"
      rank        = 8
      x_pos       = 32
      y_pos       = 29
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n  capacity = metric otelcol_exporter_queue_capacity | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | latest 1m | group_by [\"service.name\", \"exporter\"], sum;\n  size = metric otelcol_exporter_queue_size | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | latest 1m | group_by [\"service.name\", \"exporter\"], sum;\njoin size * 100.0 / capacity, capacity=1, size=0"
      }

      subtitle = ""
    }
    chart {
      name        = "Failed Spans"
      description = "Indicates that the exporter is unable to export spans as expected"
      type        = "timeseries"
      rank        = 9
      x_pos       = 16
      y_pos       = 21
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_send_failed_spans | filter (((((\"k8s.namespace.name\" == $namespace) && (\"k8s.pod.name\" == $pod)) && (\"k8s.pod.uid\" == $pod_uid)) && (\"k8s.cluster.name\" == $cluster)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\", \"exporter\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Failed Metric Points"
      description = "Indicates that the exporter is unable to export metric points as expected"
      type        = "timeseries"
      rank        = 10
      x_pos       = 0
      y_pos       = 21
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_send_failed_metric_points | filter (((((\"k8s.namespace.name\" == $namespace) && (\"k8s.pod.name\" == $pod)) && (\"k8s.pod.uid\" == $pod_uid)) && (\"k8s.cluster.name\" == $cluster)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\",  \"exporter\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Failed Log Records"
      description = "Indicates that the exporter is unable to export logs as expected"
      type        = "timeseries"
      rank        = 12
      x_pos       = 32
      y_pos       = 21
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric otelcol_exporter_send_failed_log_records | filter (((((\"k8s.namespace.name\" == $namespace) && (\"k8s.pod.name\" == $pod)) && (\"k8s.pod.uid\" == $pod_uid)) && (\"k8s.cluster.name\" == $cluster)) && (\"service.name\" == $service_name)) | rate | group_by [\"service.name\",  \"exporter\"], sum"
      }

      subtitle = ""
    }

    text_panel {
      name   = "About This Section"
      x_pos  = 0
      y_pos  = 0
      width  = 48
      height = 5
      text   = "Monitor the state of your Collector [Exporters](https://github.com/open-telemetry/opentelemetry-collector/blob/main/exporter/README.md) that send telemetry to CloudObs and any other configured destinations.\n\nCheck the Queue Usage chart to ensure data isn't piling up. The collector will queue data in memory while waiting for a worker to become available to send the data. If there aren’t enough workers or the backend is too slow, data starts piling up in the queue. Increasing the queue size might alleviate pressure on the backend destination in this case.\n\nAn increase in the Failed Spans, Metrics, Logs chart indicates that sending data to the backend failed permanently and further triage is needed.\n"
    }
  }
  group {
    rank            = 4
    title           = "Resource Usage"
    visibility_type = "explicit"

    chart {
      name        = "p99 CPU Usage [%]"
      description = "99th percentile CPU usage of the pods in each Collector pool"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 5
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.cpu.utilization | filter k8s.pod.uid == $pod_uid && k8s.pod.name == $pod && k8s.cluster.name == $cluster && k8s.namespace.name == $namespace && service.name == $service_name && service.name =~ \".*collector\" | latest | group_by [\"service.name\"], distribution | point percentile(value, 99.0) * 100"
      }

      subtitle = ""
    }
    chart {
      name        = "Memory Usage [%]"
      description = "Percent of memory used relative to available per collector pool"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 5
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "with\n  usage = metric k8s.pod.memory.usage | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | latest | group_by [\"service.name\"], sum;\n  available = metric k8s.pod.memory.available | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | latest | group_by [\"service.name\"], sum;\njoin usage / available * 100.0, usage=0, available=0"
      }

      subtitle = ""
    }
    chart {
      name        = "Network Ingress Bandwidth (bytes/sec)"
      description = "The bandwidth of network traffic received by each collector pool"
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 5
      width       = 16
      height      = 8

      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.network.io | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter \"service.name\" == $service_name && \"service.name\" =~ \".*collector\" && \"direction\" == \"receive\" | rate | group_by [\"service.name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Average CPU Usage [%]"
      description = "Average (arithmetic mean) of CPU usage of the pods in each Collector pool"
      type        = "timeseries"
      rank        = 3
      x_pos       = 0
      y_pos       = 13
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.cpu.utilization | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | latest | group_by [\"service.name\"], distribution | point percentile(value, 50.0) * 100"
      }

      subtitle = ""
    }
    chart {
      name        = "p99 Memory Used Per Pool"
      description = "99th percentile of memory used by the pods in each collector pool. This shows the upper end of memory usage across the collector pods in a pool in absolute terms."
      type        = "timeseries"
      rank        = 4
      x_pos       = 16
      y_pos       = 13
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.memory.usage | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | latest 1m | group_by [\"service.name\"], distribution | point percentile(value, 99.0)"
      }

      subtitle = ""
    }
    chart {
      name        = "Network Egress Bandwidth (bytes/sec)"
      description = "The bandwidth of network traffic transmitted by each collector pool"
      type        = "timeseries"
      rank        = 5
      x_pos       = 32
      y_pos       = 13
      width       = 16
      height      = 8

      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.pod.network.io | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter \"service.name\" == $service_name && \"service.name\" =~ \".*collector\" && \"direction\" == \"transmit\" | rate | group_by [\"service.name\"], sum"
      }

      subtitle = ""
    }

    text_panel {
      name   = "Collector Resource Usage"
      x_pos  = 0
      y_pos  = 0
      width  = 48
      height = 5
      text   = "Examine CPU and memory utilization. CPU or memory utilization approaching their capacity limits or coinciding with container restarts may indicate a scaling issue. Other symptoms may include dropped telemetry. \n\nIf data is frequently refused due to memory limits, consider scaling up. For more information on scaling see: https://docs.lightstep.com/docs/kubernetes-collector-tracing-scaling "
    }
  }
  group {
    rank            = 5
    title           = "Pod Lifecycle"
    visibility_type = "explicit"

    chart {
      name        = "Uptime Per Pod [seconds]"
      description = "The uptime of each collector pod, represented in seconds"
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 4
      width       = 16
      height      = 16

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = ""
          sort_direction = "desc"
          y_axis_min     = 0
          y_axis_max     = 0
        }
        hidden       = false
        query_string = "metric otelcol_process_uptime | filter (((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) | delta | group_by [\"k8s.pod.name\"], max"
      }

      subtitle = ""
    }
    chart {
      name        = "Pods in Running Phase"
      description = "Count of collector pods in the Running phase"
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 4
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | point_filter value == 2 | latest 1m | group_by [\"service.name\"], count_nonzero"
      }

      subtitle = ""
    }
    chart {
      name        = "Pods in Pending Phase"
      description = "Count of collector pods in the Pending phase"
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 4
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name| filter service.name =~ \".*collector\" | point_filter value == 1 | latest 1m | group_by [\"service.name\"], count_nonzero"
      }

      subtitle = ""
    }
    chart {
      name        = "Pods in Succeeded Phase"
      description = "Count of collector pods in the Succeeded phase"
      type        = "timeseries"
      rank        = 3
      x_pos       = 16
      y_pos       = 12
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | point_filter value == 3 | latest 1m | group_by [\"service.name\"], count_nonzero"
      }

      subtitle = ""
    }
    chart {
      name        = "Pods in Failed Phase"
      description = "Count of collector pods in the Failed phase"
      type        = "timeseries"
      rank        = 4
      x_pos       = 32
      y_pos       = 12
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | point_filter value == 4 | latest 1m | group_by [\"service.name\"], count_nonzero"
      }

      subtitle = ""
    }
    chart {
      name        = "Collector Pod Start Time"
      description = "The start time of each collector pod represented in UTC"
      type        = "timeseries"
      rank        = 5
      x_pos       = 0
      y_pos       = 20
      width       = 16
      height      = 16

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "k8s.pod.start_time"
          sort_direction = "desc"
          y_axis_min     = 0
          y_axis_max     = 0
        }
        hidden       = false
        query_string = "metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | latest | point_filter value == 2 | group_by [\"k8s.pod.start_time\", \"k8s.pod.name\"], count_nonzero"
      }

      subtitle = ""
    }
    chart {
      name        = "Pods in Unknown Phase"
      description = "Count of collector pods in the Unknown phase"
      type        = "timeseries"
      rank        = 6
      x_pos       = 16
      y_pos       = 20
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | point_filter value == 5 | latest 1m | group_by [\"service.name\"], count_nonzero"
      }

      subtitle = ""
    }
    chart {
      name        = "Collectors By Pod Phase"
      description = "The overall breakdown in percent of collector pods in terms of phase"
      type        = "timeseries"
      rank        = 7
      x_pos       = 32
      y_pos       = 20
      width       = 16
      height      = 8

      query {
        query_name   = "Pending"
        display      = "area"
        hidden       = false
        query_string = "with\n  pending = metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | point_filter value == 1 | latest 1m | group_by [], count_nonzero;\n  total = metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | latest 1m | group_by [], count_nonzero;\njoin pending * 100.0 / total, pending=0, total=1"
      }
      query {
        query_name   = "Running"
        display      = "area"
        hidden       = false
        query_string = "with\n  running = metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | point_filter value == 2 | latest 1m | group_by [], count_nonzero;\n  total = metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | latest 1m | group_by [], count_nonzero;\njoin running * 100.0 / total, running=0, total=1"
      }
      query {
        query_name   = "Success"
        display      = "area"
        hidden       = false
        query_string = "with\n  success = metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | point_filter value == 3 | latest 1m | group_by [], count_nonzero;\n  total = metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | latest 1m | group_by [], count_nonzero;\njoin success * 100.0 / total, success=0, total=1"
      }
      query {
        query_name   = "Failed"
        display      = "area"
        hidden       = false
        query_string = "with\n  failed = metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | point_filter value == 4 | latest 1m | group_by [], count_nonzero;\n  total = metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | latest 1m | group_by [], count_nonzero;\njoin failed * 100.0 / total, failed=0, total=1"
      }
      query {
        query_name   = "Unknown"
        display      = "area"
        hidden       = false
        query_string = "with\n  unknown = metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | point_filter value == 5 | latest 1m | group_by [], count_nonzero;\n  total = metric k8s.pod.phase | filter k8s.pod.uid == $pod_uid | filter k8s.pod.name == $pod | filter k8s.cluster.name == $cluster | filter k8s.namespace.name == $namespace | filter service.name == $service_name | filter service.name =~ \".*collector\" | latest 1m | group_by [], count_nonzero;\njoin unknown * 100.0 / total, unknown=0, total=1"
      }

      subtitle = ""
    }
    chart {
      name        = "Container Restarts Per Pool"
      description = "Container restarts per collector pool"
      type        = "timeseries"
      rank        = 8
      x_pos       = 16
      y_pos       = 28
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.restarts | filter ((((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) && (\"service.name\" =~ \".*collector\")) | delta 1m | group_by [\"service.name\"], sum | point (((value +(abs (value)))/2))"
      }

      subtitle = ""
    }
    chart {
      name        = "Container Restarts Per Pod"
      description = "Restarts by pod and container"
      type        = "timeseries"
      rank        = 9
      x_pos       = 32
      y_pos       = 28
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric k8s.container.restarts | filter ((((((\"k8s.pod.uid\" == $pod_uid) && (\"k8s.pod.name\" == $pod)) && (\"k8s.cluster.name\" == $cluster)) && (\"k8s.namespace.name\" == $namespace)) && (\"service.name\" == $service_name)) && (\"service.name\" =~ \".*collector\")) | delta 1m | group_by [\"service.name\", \"k8s.pod.name\", \"k8s.container.name\"], sum | point (((value +(abs (value)))/2))"
      }

      subtitle = ""
    }

    text_panel {
      name   = "Kubernetes pod phases"
      x_pos  = 0
      y_pos  = 0
      width  = 48
      height = 4
      text   = "This section tracks the k8s pod phases for the collector pods in each pool. Collector pods should be in the Running phase at their steady state, but will be Pending when the pod is coming up. For more details about kubernetes pod phases, see https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase"
    }
  }

  template_variable {
    name                     = "namespace"
    default_values           = []
    suggestion_attribute_key = "k8s.namespace.name"
  }
  template_variable {
    name                     = "pod_uid"
    default_values           = []
    suggestion_attribute_key = "k8s.pod.uid"
  }
  template_variable {
    name                     = "pod"
    default_values           = []
    suggestion_attribute_key = "k8s.pod.name"
  }
  template_variable {
    name                     = "cluster"
    default_values           = []
    suggestion_attribute_key = "k8s.cluster.name"
  }
  template_variable {
    name                     = "service_name"
    default_values           = []
    suggestion_attribute_key = "service.name"
  }

  label {
    key   = ""
    value = "recommended"
  }
  label {
    key   = ""
    value = "kubernetes"
  }
  label {
    key   = ""
    value = "collector-health"
  }
}
