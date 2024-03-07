terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.92.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_nomad_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Hashcorp Nomad Server"
  dashboard_description = "Monitor Hashcorp Nomad Server metrics with the OTel Collector's Prometheus receiver."

  chart {
    name = "Client Allocated CPU"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocated_disk | latest | group_by [], sum"
    }

  }

  chart {
    name = "Raft FSM Apply Count"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_raft_barrier | rate | group_by [], sum"
    }

  }

  chart {
    name = "Client Allocated Memory"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocated_memory | latest | group_by [], sum"
    }

  }

  chart {
    name = "Client Host CPU IDLE"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_host_cpu_idle | latest | group_by [], sum"
    }

  }

  chart {
    name = "Client Host CPU System"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_host_cpu_system | latest | group_by [], sum"
    }

  }

  chart {
    name = "Client Host Disk Available"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_host_disk_available | latest | group_by [], sum"
    }

  }

  chart {
    name = "Client Allocated IOPS"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocated_iops | latest | group_by [], sum"
    }

  }

  chart {
    name = "Client Allocated CPU"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocated_cpu | latest | group_by [], sum"
    }

  }

  chart {
    name = "Client Uptime"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric nomad_client_uptime | latest | group_by [], sum"
    }

  }

  chart {
    name = "Client Allocations BLocked"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric nomad_client_allocations_blocked | latest | group_by [], sum"
    }

  }

  chart {
    name = "Runtime Heap Objects"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric nomad_runtime_heap_objects | latest | group_by [], sum"
    }

  }

  chart {
    name = "Eval ACK Sum"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = "metric nomad_nomad_eval_ack_sum | rate | group_by [], sum"
    }

  }

}

