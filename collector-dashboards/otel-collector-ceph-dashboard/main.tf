terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.88.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_ceph_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Ceph - Overview"
  dashboard_description = "Track Ceph throughput, latency metrics and identify bottlenecks with the performance monitoring dashboard."

  group {
    rank            = 1
    title           = "OSD State"
    visibility_type = "explicit"

    chart {
      name   = "Avg Op Read Latency"
      type   = "timeseries"
      rank   = 1
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "(a/b)"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric ceph_osd_op_r_latency_sum | rate 5m, 5m | group_by [], sum;\n  b = metric ceph_osd_op_r_latency_count | rate 5m, 5m | group_by [], sum;\njoin ((a / b)), a=0, b=0 | reduce 5m, mean"
      }
    }
    chart {
      name   = "Avg Op Write Latency"
      type   = "timeseries"
      rank   = 2
      x_pos  = 16
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "(a/b)"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric ceph_osd_op_w_latency_sum | rate 5m, 5m | group_by [], sum;\n  b = metric ceph_osd_op_w_latency_count | rate 5m, 5m | group_by [], sum;\njoin ((a / b)), a=0, b=0 | reduce 5m, mean"
      }
    }
    chart {
      name   = "Avg Commit Latency"
      type   = "timeseries"
      rank   = 17
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_osd_commit_latency_ms | latest | group_by [], mean"
      }
    }
    chart {
      name   = "Avg Apply Latency"
      type   = "timeseries"
      rank   = 18
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_osd_apply_latency_ms | latest | group_by [], mean"
      }
    }
    chart {
      name   = "OSDs OUT"
      type   = "timeseries"
      rank   = 31
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "(a-b)"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric ceph_osd_up | latest | group_by [], count;\n  b = metric ceph_osd_in | latest | group_by [], count;\njoin ((a - b)), a=0, b=0"
      }
    }
    chart {
      name   = "OSDs UP"
      type   = "timeseries"
      rank   = 32
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_osd_up | latest | group_by [], sum"
      }
    }
    chart {
      name   = "OSDs IN"
      type   = "timeseries"
      rank   = 33
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_osd_in | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Avg PGs"
      type   = "timeseries"
      rank   = 34
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_osd_numpg | latest | group_by [], mean"
      }
    }
  }
  group {
    rank            = 2
    title           = "Cluster"
    visibility_type = "explicit"

    chart {
      name   = "Capacity"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "(a-b)"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric ceph_cluster_total_bytes | latest | group_by [], sum;\n  b = metric ceph_cluster_total_used_bytes | latest | group_by [], sum;\njoin ((a - b)), a=0, b=0"
      }
    }
    chart {
      name   = "IOPS"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_osd_op_w | rate 5m | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_osd_op_r | rate 5m | group_by [], sum"
      }
    }
    chart {
      name   = "Throughput"
      type   = "timeseries"
      rank   = 5
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_osd_op_w_in_bytes | rate 5m | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_osd_op_r_out_bytes | rate 5m | group_by [], sum"
      }
    }
    chart {
      name   = "Pool Used Bytes"
      type   = "timeseries"
      rank   = 6
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pool_bytes_used | latest | group_by [\"pool_id\"], sum"
      }
    }
    chart {
      name   = "Pool RAW Used Bytes"
      type   = "timeseries"
      rank   = 7
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pool_raw_bytes_used | latest | group_by [\"pool_id\"], sum"
      }
    }
    chart {
      name   = "Objects Per Pool"
      type   = "timeseries"
      rank   = 8
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pool_objects | latest | group_by [\"pool_id\"], sum"
      }
    }
    chart {
      name   = "Pool Quota Bytes"
      type   = "timeseries"
      rank   = 9
      x_pos  = 16
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pool_quota_bytes | latest | group_by [\"pool_id\"], sum"
      }
    }
    chart {
      name   = "Pool Objects Quota"
      type   = "timeseries"
      rank   = 10
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pool_quota_objects | latest | group_by [\"pool_id\"], sum"
      }
    }
  }
  group {
    rank            = 3
    title           = "Objects"
    visibility_type = "explicit"

    chart {
      name   = "Objects In The Cluster"
      type   = "timeseries"
      rank   = 11
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_cluster_total_objects | latest | group_by [], sum"
      }
    }
    chart {
      name   = "PGs State"
      type   = "timeseries"
      rank   = 12
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_active | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_clean | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_peering | latest | group_by [], sum"
      }
      query {
        query_name   = "d"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_degraded | latest | group_by [], sum"
      }
      query {
        query_name   = "e"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_stale | latest | group_by [], sum"
      }
      query {
        query_name   = "f"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pool_dirty | latest | group_by [], sum"
      }
      query {
        query_name   = "g"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_undersized | latest | group_by [], sum"
      }
      query {
        query_name   = "h"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_incomplete | latest | group_by [], sum"
      }
      query {
        query_name   = "i"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_forced_backfill | latest | group_by [], sum"
      }
      query {
        query_name   = "j"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_inconsistent | latest | group_by [], sum"
      }
      query {
        query_name   = "k"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_forced_recovery | latest | group_by [], sum"
      }
      query {
        query_name   = "l"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_creating | latest | group_by [], sum"
      }
      query {
        query_name   = "m"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_backfill_wait | latest | group_by [], sum"
      }
      query {
        query_name   = "n"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_deep | latest | group_by [], sum"
      }
      query {
        query_name   = "o"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_scrubbing | latest | group_by [], sum"
      }
      query {
        query_name   = "p"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_recovering | latest | group_by [], sum"
      }
      query {
        query_name   = "q"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_repair | latest | group_by [], sum"
      }
      query {
        query_name   = "r"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_down | latest | group_by [], sum"
      }
      query {
        query_name   = "s"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_peered | latest | group_by [], sum"
      }
      query {
        query_name   = "t"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_backfilling | latest | group_by [], sum"
      }
      query {
        query_name   = "u"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_remapped | latest | group_by [], sum"
      }
      query {
        query_name   = "v"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_backfill_toofull | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Stuck PGs"
      type   = "timeseries"
      rank   = 13
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_degraded | latest | group_by [], sum"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_stale | latest | group_by [], sum"
      }
      query {
        query_name   = "c"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_pg_undersized | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Recovery Operations"
      type   = "timeseries"
      rank   = 14
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_osd_recovery_ops | rate | group_by [], sum"
      }
    }
    chart {
      name   = "AVG OSD Apply + Commit Latency"
      type   = "timeseries"
      rank   = 15
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_osd_commit_latency_ms | latest | group_by [], mean"
      }
      query {
        query_name   = "b"
        display      = "line"
        hidden       = false
        query_string = "metric ceph_osd_apply_latency_ms | latest | group_by [], mean"
      }
    }
    chart {
      name   = "Avg OSD Op Write Latency"
      type   = "timeseries"
      rank   = 16
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "(a/b)"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric ceph_osd_op_w_latency_sum | rate 5m, 5m | group_by [], sum;\n  b = metric ceph_osd_op_w_latency_count | rate 5m, 5m | group_by [], sum;\njoin ((a / b)), a=0, b=0 | reduce 5m, mean"
      }
    }
    chart {
      name   = "Avg OSD Op Read Latency"
      type   = "timeseries"
      rank   = 35
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "(a/b)"
        display      = "line"
        hidden       = false
        query_string = "with\n  a = metric ceph_osd_op_r_latency_sum | rate 5m, 5m | group_by [], sum;\n  b = metric ceph_osd_op_r_latency_count | rate 5m, 5m | group_by [], sum;\njoin ((a / b)), a=0, b=0 | reduce 5m, mean"
      }
    }
  }
  group {
    rank            = 0
    title           = "Cluster State"
    visibility_type = "explicit"

    chart {
      name   = "Healthy Instances"
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
        query_string = "metric ceph_health_status | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Write Throughput"
      type   = "timeseries"
      rank   = 19
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_osd_op_w_in_bytes | rate 5m | group_by [], sum"
      }
    }
    chart {
      name   = "Read Throughput"
      type   = "timeseries"
      rank   = 20
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_osd_op_rw_out_bytes | rate 5m | group_by [], sum"
      }
    }
    chart {
      name   = "Cluster Capacity"
      type   = "timeseries"
      rank   = 21
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_cluster_total_bytes | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Available Capacity"
      type   = "timeseries"
      rank   = 22
      x_pos  = 32
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "(((a-b)/a)*100)"
        display      = "bar"
        hidden       = false
        query_string = "with\n  a = metric ceph_cluster_total_bytes | latest | group_by [], sum;\n  b = metric ceph_cluster_total_used_bytes | latest | group_by [], sum;\njoin ((((a - b)/ a)*100)), a=0, b=0"
      }
    }
    chart {
      name   = "Number of Objects"
      type   = "timeseries"
      rank   = 23
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_cluster_total_objects | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Bytes Written"
      type   = "timeseries"
      rank   = 24
      x_pos  = 0
      y_pos  = 24
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_osd_op_w_in_bytes | delta | group_by [], sum"
      }
    }
    chart {
      name   = "Bytes Read"
      type   = "timeseries"
      rank   = 25
      x_pos  = 16
      y_pos  = 24
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_osd_op_r_out_bytes | delta | group_by [], sum"
      }
    }
    chart {
      name   = "Write IOPS"
      type   = "timeseries"
      rank   = 26
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_osd_op_w | rate 5m | group_by [], sum"
      }
    }
    chart {
      name   = "Read IOPS"
      type   = "timeseries"
      rank   = 27
      x_pos  = 16
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_osd_op_r | rate 5m | group_by [], sum"
      }
    }
    chart {
      name   = "Used Capacity"
      type   = "timeseries"
      rank   = 28
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_cluster_total_used_bytes | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Mon Session Num"
      type   = "timeseries"
      rank   = 29
      x_pos  = 0
      y_pos  = 32
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_mon_num_sessions | latest | group_by [], sum"
      }
    }
    chart {
      name   = "Monitors In Quorum"
      type   = "timeseries"
      rank   = 30
      x_pos  = 16
      y_pos  = 32
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric ceph_mon_quorum_status | latest | group_by [], sum"
      }
    }
  }
}