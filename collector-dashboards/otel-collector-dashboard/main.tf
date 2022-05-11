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
    name = "Prometheus targets by job, metrics_path"
    rank = 1
    type = "timeseries"
    query {
      query_name = "a"
      display    = "bar"
      hidden     = false
      tql        = <<EOT
metric scrape_samples_scraped
| reduce 1m, count
| group_by [job, metrics_path], count
EOT
    }
  }
  chart {
    name = "Receiver Scrape duration"
    rank = 2
    type = "timeseries"
    query {
      query_name = "a"
      display    = "line"
      hidden     = false
      tql        = <<EOT
metric scrape_duration_seconds
| latest
| group_by [job], mean
EOT
    }
  }
  chart {
    name = "Collector up"
    rank = 3
    type = "timeseries"
    query {
      query_name = "a"
      display    = "bar"
      hidden     = false
      tql        = <<EOT
metric otelcol_process_uptime
| rate
| group_by [k8s_cluster_name,job,service_instance_id], sum
EOT
    }
  }

  chart {
    name = "Otel collector dropped and failed metric points"
    rank = 4
    type = "timeseries"
    query {
      query_name = "failed"
      display    = "line"
      hidden     = false
      tql        = <<EOT
metric otelcol_exporter_send_failed_metric_points
| delta
| group_by [exporter], sum
EOT
    }
    query {
      query_name = "dropped"
      display    = "line"
      hidden     = false
      tql        = <<EOT
metric otelcol_processor_dropped_metric_points
| delta
| group_by [exporter], sum
EOT
    }
  }
  chart {
    name = "Otel batch send size"
    rank = 5
    type = "timeseries"
    query {
      query_name = "a"
      display    = "line"
      hidden     = false
      tql        = <<EOT
metric otelcol_processor_batch_batch_send_size
| delta
| group_by [processor], sum
| point percentile(value, 50),
  percentile(value, 95),
  percentile(value, 99),
    percentile(value, 99.9)
EOT
    }
  }
  chart {
    name = "Otel Cpu usage vs limits"
    rank = 6
    type = "timeseries"
    query {
      query_name = "limits"
      display    = "line"
      hidden     = false
      tql        = <<EOT
metric kube_pod_container_resource_limits
| latest
| filter resource == "cpu"
| filter container == "otc-container"
| group_by [], sum
EOT
    }
    query {
      query_name = "requests"
      display    = "line"
      hidden     = false
      tql        = <<EOT
metric kube_pod_container_resource_requests
| latest
| filter resource == "cpu"
| filter container == "otc-container"
| group_by [], sum
EOT
    }
    query {
      query_name = "usage"
      display    = "line"
      hidden     = false
      tql        = <<EOT
    metric container_cpu_usage_seconds_total
    | rate
    | filter container == "otc-container"
    | group_by [], sum
    EOT
    }
  }
  chart {
    name = "Collector exporter queue size"
    rank = 7
    type = "timeseries"
    query {
      query_name = "a"
      display    = "line"
      hidden     = false
      tql        = <<EOT
metric otelcol_exporter_queue_size
| latest
| group_by [exporter], sum
EOT
    }
  }
  chart {
    name = "Otel points accepted vs refused"
    rank = 8
    type = "timeseries"
    query {
      query_name = "accepted"
      display    = "bar"
      hidden     = false
      tql        = <<EOT
metric otelcol_receiver_accepted_metric_points
| delta
| group_by [receiver], sum
EOT
    }
    query {
      query_name = "refused"
      display    = "bar"
      hidden     = false
      tql        = <<EOT
metric otelcol_receiver_refused_metric_points
| delta
| group_by [receiver], sum
EOT
    }
  }
  chart {
    name = "Otel Memory usage vs limits"
    rank = 9
    type = "timeseries"
    query {
      query_name = "limits"
      display    = "line"
      hidden     = false
      tql        = <<EOT
metric kube_pod_container_resource_limits
| latest
| filter resource == "memory"
| filter container == "otc-container"
| group_by [pod], sum
EOT
    }
    query {
      query_name = "requests"
      display    = "line"
      hidden     = false
      tql        = <<EOT
metric kube_pod_container_resource_requests
| latest
| filter resource == "memory"
| filter container == "otc-container"
| group_by [pod], sum
EOT
    }
    query {
      query_name = "usage"
      display    = "line"
      hidden     = false
      tql        = <<EOT
    metric container_memory_working_set_bytes
    | latest
    | filter container == "otc-container"
    | group_by [pod], sum
    EOT
    }
  }

  chart {
    name = "Hourly active time series by service"
    rank = 10
    type = "timeseries"
    query {
      query_name = "a"
      display    = "bar"
      hidden     = false
      tql        = <<EOT
metric lightstep.hourly_active_time_series
| delta 1h
| group_by [service], sum
EOT
    }
  }
}
