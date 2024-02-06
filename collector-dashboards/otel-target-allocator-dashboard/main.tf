terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.89.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_target_allocator_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OTel Target Allocator"
  dashboard_description = "Monitor OpenTelemetry Target Allocator with this overview dashboard."

  chart {
    name = "Targets per Collector"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric opentelemetry_allocator_targets_per_collector | latest | group_by ["collector_name"], sum
EOT
    }

  }

  chart {
    name = "Allocatable vs. Discovered"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric opentelemetry_allocator_collectors_allocatable | latest | group_by [], sum"
    }

    query {
      query_name   = "b"
      display      = "bar"
      hidden       = false
      query_string = "metric opentelemetry_allocator_collectors_discovered | latest | group_by [], sum"
    }

  }

  chart {
    name = "Allocator Events"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric opentelemetry_allocator_events | delta | group_by ["source"], sum
EOT
    }

  }

  chart {
    name = "Targets Discovered"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric opentelemetry_allocator_targets | latest | group_by ["job_name"], sum
EOT
    }

  }

  chart {
    name = "HTTP Response Time"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric opentelemetry_allocator_http_duration_seconds
| delta 5m
| group_by [path], sum
| point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0)

EOT
    }

  }

  chart {
    name = "Kubernetes Events"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric prometheus_sd_kubernetes_events_total | rate | group_by ["event", "role"], sum
EOT
    }

  }

  chart {
    name = "Time to Allocate"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric opentelemetry_allocator_time_to_allocate
| delta 5m
| group_by [method], sum
| point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0)

EOT
    }

  }

  chart {
    name = "Target Allocator Scrapes"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric scrape_series_added | latest | group_by ["collector.name"], sum
EOT
    }

  }

  chart {
    name = "Allocation by Method Count"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric opentelemetry_allocator_time_to_allocate
| delta 5m
| group_by [method], sum
| point dist_count(value)

EOT
    }

  }

}
