terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.6"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_operator_dashboard" {
    dashboard_name = "OpenTelemetry Operator"
    project_name   = var.lightstep_project

    chart {
        name = "Restarts in the past 30 mins"
        rank = 5
        type = "timeseries"

        query {
            display             = "bar"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "kube_pod_container_status_restarts_total"
            query_name          = "a"
            timeseries_operator = "rate"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "pod",
                ]
            }
        }
    }
    chart {
        name = "Reconcile Errors"
        rank = 2
        type = "timeseries"

        query {
            display             = "bar"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "controller_runtime_reconcile_errors_total"
            query_name          = "a"
            timeseries_operator = "delta"

            group_by {
                aggregation_method = "max"
                keys               = [
                    "controller",
                ]
            }
        }
    }
    chart {
        name = "Time to reconcile"
        rank = 1
        type = "timeseries"

        query {
            display             = "heatmap"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "controller_runtime_reconcile_time_seconds"
            query_name          = "a"
            timeseries_operator = "delta"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "controller",
                ]
            }
        }
    }
    chart {
        name = "Total reconciles"
        rank = 0
        type = "timeseries"

        query {
            display             = "line"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "controller_runtime_reconcile_total"
            query_name          = "a"
            timeseries_operator = "delta"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "controller",
                    "result",
                    "pod",
                ]
            }
        }
    }
    chart {
        name = "CPU Usage"
        rank = 3
        type = "timeseries"

        query {
            display             = "line"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "container_cpu_usage_seconds_total"
            query_name          = "a"
            timeseries_operator = "rate"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "pod",
                ]
            }
        }
        query {
            display             = "line"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "kube_pod_container_resource_requests"
            query_name          = "b"
            timeseries_operator = "last"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "pod",
                ]
            }
        }
        query {
            display             = "line"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "kube_pod_container_resource_limits"
            query_name          = "c"
            timeseries_operator = "last"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "pod",
                ]
            }
        }
    }
    chart {
        name = "Memory Usage"
        rank = 4
        type = "timeseries"

        query {
            display             = "line"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "container_memory_working_set_bytes"
            query_name          = "a"
            timeseries_operator = "last"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "pod",
                ]
            }
        }
        query {
            display             = "line"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "kube_pod_container_resource_requests"
            query_name          = "b"
            timeseries_operator = "last"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "pod",
                ]
            }
        }
        query {
            display             = "line"
            exclude_filters     = []
            hidden              = false
            include_filters     = []
            metric              = "kube_pod_container_resource_limits"
            query_name          = "c"
            timeseries_operator = "last"

            group_by {
                aggregation_method = "sum"
                keys               = [
                    "pod",
                ]
            }
        }
    }
}