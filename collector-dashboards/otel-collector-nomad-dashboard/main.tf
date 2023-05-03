terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.76.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_nomadreceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Nomad"
  dashboard_description = "Monitor Nomad with this overview dashboard."

  chart {
    name = "CPU"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocated_cpu | delta | group_by [], sum"
    }

  }

  chart {
    name = "Disk"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocated_disk | delta | group_by [], sum"
    }

  }

  chart {
    name = "IOPS"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocated_iops | delta | group_by [], sum"
    }

  }

  chart {
    name = "Memory"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocated_memory | delta | group_by [], sum"
    }

  }

  chart {
    name = "Network"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocated_network | delta | group_by [], sum"
    }

  }

  chart {
    name = "Allocations blocked"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocations_blocked | delta | group_by [], sum"
    }

  }

  chart {
    name = "Migrating Allocations"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocations_migrating | delta | group_by [], sum"
    }

  }

  chart {
    name = "Pending Allocations"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocations_pending | delta | group_by [], sum"
    }

  }

  chart {
    name = "Running Allocations"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocations_running | delta | group_by [], sum"
    }

  }

  chart {
    name = "Starting Allocations"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocations_start | delta | group_by [], sum"
    }

  }

  chart {
    name = "Terminated Allocations"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocations_terminal | delta | group_by [], sum"
    }

  }

  chart {
    name = "Total CPU allocated"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocs_cpu_allocated | delta | group_by [], sum"
    }

  }
}
