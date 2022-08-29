terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.61.2"
    }
  }
  required_version = ">= v1.0.11"
}
resource "lightstep_metric_dashboard" "otel_target_allocator_dashboard" {
    dashboard_name = "OpenTelemetry Target Allocator"
    project_name   = var.lightstep_project

    chart {
        name = "Allocatable vs discovered"
        rank = 1
        type = "timeseries"

        query {
            display             = "bar"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "opentelemetry_allocator_collectors_allocatable"
            query_name          = "a"
            timeseries_operator = "last"

            group_by {
                aggregation_method = "sum"
                keys               = []
            }
        }
        query {
            display             = "bar"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "opentelemetry_allocator_collectors_discovered"
            query_name          = "b"
            timeseries_operator = "last"

            group_by {
                aggregation_method = "sum"
                keys               = []
            }
        }
    }
    chart {
        name = "Targets per collector"
        rank = 0
        type = "timeseries"

        query {
            display             = "bar"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "opentelemetry_allocator_targets_per_collector"
            query_name          = "a"
            timeseries_operator = "last"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "collector_name",
                ]
            }
        }
    }
    chart {
        name = "Time to Allocate"
        rank = 6
        type = "timeseries"

        query {
            display             = "line"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "opentelemetry_allocator_time_to_allocate"
            query_name          = "a"
            timeseries_operator = "delta"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "method",
                ]
            }
        }
    }
    chart {
        name = "Targets Discovered"
        rank = 3
        type = "timeseries"

        query {
            display             = "bar"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "opentelemetry_allocator_targets"
            query_name          = "a"
            timeseries_operator = "last"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "job_name",
                ]
            }
        }
    }
    chart {
        name = "Target allocator scrapes"
        rank = 7
        type = "timeseries"

        query {
            display             = "bar"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "scrape_series_added"
            query_name          = "a"
            timeseries_operator = "last"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "collector.name",
                ]
            }
        }
    }
    chart {
        name = "HTTP Response Time"
        rank = 4
        type = "timeseries"

        query {
            display             = "line"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "opentelemetry_allocator_http_duration_seconds"
            query_name          = "a"
            timeseries_operator = "delta"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "path",
                ]
            }
        }
    }
    chart {
        name = "Kubernetes events"
        rank = 5
        type = "timeseries"

        query {
            display             = "line"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "prometheus_sd_kubernetes_events_total"
            query_name          = "a"
            timeseries_operator = "rate"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "event",
                    "role",
                ]
            }
        }
    }
    chart {
        name = "Allocation by method count"
        rank = 8
        type = "timeseries"

        query {
            display         = "bar"
            exclude_filters = []
            hidden          = false
            include_filters = []
            query_name      = "a"
            tql             = <<-EOT
                metric opentelemetry_allocator_time_to_allocate
                | delta 5m
                | group_by [method], sum
                | point dist_count(value)
            EOT
        }
    }
    chart {
        name = "Allocator Events"
        rank = 2
        type = "timeseries"

        query {
            display             = "bar"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "opentelemetry_allocator_events"
            query_name          = "a"
            timeseries_operator = "delta"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "source",
                ]
            }
        }
    }
}
