terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_etcd_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "ETCD v3 - Overview"
  dashboard_description = "Etcd Cluster Overview showing details scraped from the etcd Prometheus metrics endpoint."

  group {
    rank            = 1
    title           = ""
    visibility_type = "implicit"

    chart {
      name   = "Successful Health Checks"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric etcd_server_health_success | rate | group_by [], count"
      }
    }
    chart {
      name   = "Leaders"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric etcd_server_has_leader | latest | group_by [], mean"
      }
    }
    chart {
      name   = "Health Failures"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_server_heartbeat_send_failures_total | rate | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_server_health_failures | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Client Traffic In"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric etcd_network_client_grpc_received_bytes_total | rate 5m | group_by [], sum"
      }
    }
  }
  group {
    rank            = 4
    title           = "Active Streams"
    visibility_type = "explicit"

    chart {
      name   = "Watch Streams"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "(a-b)"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric grpc_server_started_total | filter ((grpc_service == \"etcdserverpb.Watch\") && (grpc_type == \"bidi_stream\")) | rate | group_by [], sum;\n  b = metric grpc_server_handled_total | filter ((grpc_service == \"etcdserverpb.Watch\") && (grpc_type == \"bidi_stream\")) | rate | group_by [], sum;\njoin ((a - b)), a=0, b=0"
      }
    }
    chart {
      name   = "Lease Streams"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "(a-b)"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric grpc_server_started_total | filter ((grpc_service == \"etcdserverpb.Lease\") && (grpc_type == \"bidi_stream\")) | rate 2m | group_by [], sum;\n  b = metric grpc_server_handled_total | filter ((grpc_service == \"etcdserverpb.Lease\") && (grpc_type == \"bidi_stream\")) | rate 2m | group_by [], sum;\njoin ((a - b)), a=0, b=0"
      }
    }
  }
  group {
    rank            = 0
    title           = "Health"
    visibility_type = "explicit"
  }
  group {
    rank            = 2
    title           = "Disk"
    visibility_type = "explicit"

    chart {
      name   = "Total Number of Bytes Written in WAL"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric etcd_disk_wal_write_bytes_total | reduce mean | group_by [], mean"
      }
    }
    chart {
      name   = "DB Size"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_mvcc_db_total_size_in_bytes | latest | group_by [\"net.host.name\"], sum"
      }
    }
    chart {
      name   = "Fsync Duration Percentile"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_disk_wal_fsync_duration_seconds | delta | group_by [\"net.host.name\"], sum | point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)"
      }
    }
    chart {
      name   = "Commit Duration Percentile"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_disk_backend_commit_duration_seconds | delta | group_by [\"net.host.name\"], sum | point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)"
      }
    }
    chart {
      name   = "Snapshot Duration Percentile"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_disk_backend_commit_duration_seconds | delta | group_by [\"net.host.name\"], sum | point percentile(value, 50.0), percentile(value, 95.0), percentile(value, 99.0), percentile(value, 99.9)"
      }
    }
  }
  group {
    rank            = 3
    title           = "Network"
    visibility_type = "explicit"

    chart {
      name   = "Client GRPC Tracffic (Bytes)"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_network_client_grpc_received_bytes_total | delta | group_by [], mean"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_network_client_grpc_sent_bytes_total | delta | group_by [], mean"
      }
    }
    chart {
      name   = "Peer Sent (Bytes)"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_network_peer_sent_failures_total | rate | group_by [], mean"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_network_peer_sent_bytes_total | rate | group_by [], mean"
      }
    }
    chart {
      name   = "Active Vs Disconnected Peers"
      type   = "timeseries"
      rank   = 2
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_network_active_peers | rate | group_by [\"net.host.name\"], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_network_disconnected_peers | rate | group_by [], sum"
      }
    }
    chart {
      name   = "Peer Received (Bytes)"
      type   = "timeseries"
      rank   = 3
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_network_peer_received_failures_total | rate | group_by [], mean"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_network_peer_received_bytes_total | rate | group_by [], sum"
      }
    }
  }
  group {
    rank            = 5
    title           = "Server"
    visibility_type = "explicit"

    chart {
      name   = "Total Leader Changes Seen"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric etcd_server_leader_changes_seen_total | rate | group_by [\"net.host.name\"], sum"
      }
    }
    chart {
      name   = "Failed Proposals"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric etcd_server_proposals_failed_total | rate | group_by [\"net.host.name\"], sum"
      }
    }
    chart {
      name   = "Pending Proposals"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "bar"
        hidden       = false
        query_string = "metric etcd_server_proposals_pending | latest | group_by [\"net.host.name\"], sum"
      }
    }
    chart {
      name   = "Total Commited Proposals"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_server_proposals_committed_total | latest | group_by [\"net.host.name\"], sum"
      }
    }
    chart {
      name   = "Total Applied Proposals"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric etcd_server_proposals_applied_total | latest | group_by [\"net.host.name\"], sum"
      }
    }
    chart {
      name   = "Diff Applied/Committed"
      type   = "timeseries"
      rank   = 5
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "(a-b)"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric etcd_server_proposals_applied_total | latest | group_by [\"net.host.name\"], sum;\n  b = metric etcd_server_proposals_committed_total | latest | group_by [\"net.host.name\"], sum;\njoin ((a - b)), a=0, b=0"
      }
    }
  }
  group {
    rank            = 6
    title           = "New Section"
    visibility_type = "explicit"

    chart {
      name   = "Allocated Bytes"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric go_memstats_alloc_bytes | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Allocated Heap"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric go_memstats_heap_alloc_bytes | latest | group_by [], sum"
      }
    }
    chart {
      name   = "MSpan Bytes"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric go_memstats_mspan_inuse_bytes | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Profiling Bucket Hash Table Size"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric go_memstats_buck_hash_sys_bytes | latest | group_by [], sum"
      }
    }
  }
  group {
    rank            = 7
    title           = "File Descriptors"
    visibility_type = "explicit"

    chart {
      name   = "Process Open Vs Max File Descriptors"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric process_open_fds | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric process_max_fds | latest | group_by [], sum"
      }
    }
    chart {
      name   = "OS Used Vs Limit File Descriptors"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric os_fd_used | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric os_fd_limit | latest | group_by [], sum"
      }
    }
  }
}