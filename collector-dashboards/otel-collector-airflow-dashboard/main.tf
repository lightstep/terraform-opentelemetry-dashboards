terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.84.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_airflowreceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "OpenTelemetry Airflow Integration"
  dashboard_description = "Monitor Airflow with this metrics overview dashboard."

  chart {
    name = "Processes"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric airflow.dag_processing.processes | delta | group_by [], sum"
    }

  }

  chart {
    name = "Started jobs"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric airflow.schedulerjob_start | delta | group_by [], sum"
    }

  }

  chart {
    name = "Ended jobs"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric airflow.schedulerjob_end | delta | group_by [], sum"
    }

  }

  chart {
    name = "Running tasks"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric airflow.scheduler.tasks.running | delta | group_by [], sum"
    }

  }

  chart {
    name = "Waiting tasks"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric airflow.scheduler.tasks.starving | delta | group_by [], sum"
    }

  }

  chart {
    name = "Cleared orphaned tasks"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric airflow.scheduler.orphaned_tasks.cleared | delta | group_by [], sum"
    }

  }

  chart {
    name = "Adopted orphaned tasks"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric airflow.scheduler.orphaned_tasks.adopted | delta | group_by [], sum"
    }

  }

  chart {
    name = "Dags scan time"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric airflow.dag_processing.total_parse_time | latest | group_by [], sum"
    }

  }

  chart {
    name = "Active threads in the worker process"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric airflow.dag_processing.import_errors | delta | group_by [], sum"
    }

  }

  chart {
    name = "Dags import errors"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric airflow.pool.open_slots.default_pool | delta | group_by [], sum"
    }

  }

  chart {
    name = "Queued slots"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric airflow.pool.queued_slots.default_pool | delta | group_by [], sum"
    }

  }

}
