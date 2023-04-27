terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_ceph_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Ceph - Overview"
  dashboard_description = "Track Ceph throughput, latency metrics and identify bottlenecks with the performance monitoring dashboard."

  chart {
    name = "Healthy Instances"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_health_status | latest | group_by [], sum"
    }

  }

  chart {
    name = "Avg Op Read Latency"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a/b)"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
with
  a = metric ceph_osd_op_r_latency_sum | rate 5m, 5m | group_by [], sum;
  b = metric ceph_osd_op_r_latency_count | rate 5m, 5m | group_by [], sum;
join ((a / b)), a=0, b=0 | reduce 5m, mean
EOT
    }

  }

  chart {
    name = "Avg Op Write Latency"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a/b)"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
with
  a = metric ceph_osd_op_w_latency_sum | rate 5m, 5m | group_by [], sum;
  b = metric ceph_osd_op_w_latency_count | rate 5m, 5m | group_by [], sum;
join ((a / b)), a=0, b=0 | reduce 5m, mean
EOT
    }

  }

  chart {
    name = "Capacity"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a-b)"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric ceph_cluster_total_bytes | latest | group_by [], sum;
  b = metric ceph_cluster_total_used_bytes | latest | group_by [], sum;
join ((a - b)), a=0, b=0
EOT
    }

  }

  chart {
    name = "IOPS"
    rank = "0"
    type = "timeseries"

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
    name = "Throughput"
    rank = "0"
    type = "timeseries"

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
    name = "Pool Used Bytes"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ceph_pool_bytes_used | latest | group_by ["pool_id"], sum
EOT
    }

  }

  chart {
    name = "Pool RAW Used Bytes"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ceph_pool_raw_bytes_used | latest | group_by ["pool_id"], sum
EOT
    }

  }

  chart {
    name = "Objects Per Pool"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ceph_pool_objects | latest | group_by ["pool_id"], sum
EOT
    }

  }

  chart {
    name = "Pool Quota Bytes"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ceph_pool_quota_bytes | latest | group_by ["pool_id"], sum
EOT
    }

  }

  chart {
    name = "Pool Objects Quota"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric ceph_pool_quota_objects | latest | group_by ["pool_id"], sum
EOT
    }

  }

  chart {
    name = "Objects In The Cluster"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ceph_cluster_total_objects | latest | group_by [], sum"
    }

  }

  chart {
    name = "PGs State"
    rank = "0"
    type = "timeseries"

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
    name = "Stuck PGs"
    rank = "0"
    type = "timeseries"

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
    name = "Recovery Operations"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric ceph_osd_recovery_ops | rate | group_by [], sum"
    }

  }

  chart {
    name = "AVG OSD Apply + Commit Latency"
    rank = "0"
    type = "timeseries"

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
    name = "Avg OSD Op Write Latency"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a/b)"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric ceph_osd_op_w_latency_sum | rate 5m, 5m | group_by [], sum;
  b = metric ceph_osd_op_w_latency_count | rate 5m, 5m | group_by [], sum;
join ((a / b)), a=0, b=0 | reduce 5m, mean
EOT
    }

  }

  chart {
    name = "Avg Commit Latency"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_osd_commit_latency_ms | latest | group_by [], mean"
    }

  }

  chart {
    name = "Avg Apply Latency"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_osd_apply_latency_ms | latest | group_by [], mean"
    }

  }

  chart {
    name = "Write Throughput"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_osd_op_w_in_bytes | rate 5m | group_by [], sum"
    }

  }

  chart {
    name = "Read Throughput"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_osd_op_rw_out_bytes | rate 5m | group_by [], sum"
    }

  }

  chart {
    name = "Cluster Capacity"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_cluster_total_bytes | latest | group_by [], sum"
    }

  }

  chart {
    name = "Available Capacity"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(((a-b)/a)*100)"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
with
  a = metric ceph_cluster_total_bytes | latest | group_by [], sum;
  b = metric ceph_cluster_total_used_bytes | latest | group_by [], sum;
join ((((a - b)/ a)*100)), a=0, b=0
EOT
    }

  }

  chart {
    name = "Number of Objects"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_cluster_total_objects | latest | group_by [], sum"
    }

  }

  chart {
    name = "Bytes Written"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_osd_op_w_in_bytes | delta | group_by [], sum"
    }

  }

  chart {
    name = "Bytes Read"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_osd_op_r_out_bytes | delta | group_by [], sum"
    }

  }

  chart {
    name = "Write IOPS"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_osd_op_w | rate 5m | group_by [], sum"
    }

  }

  chart {
    name = "Read IOPS"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_osd_op_r | rate 5m | group_by [], sum"
    }

  }

  chart {
    name = "Used Capacity"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_cluster_total_used_bytes | latest | group_by [], sum"
    }

  }

  chart {
    name = "Mon Session Num"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_mon_num_sessions | latest | group_by [], sum"
    }

  }

  chart {
    name = "Monitors In Quorum"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_mon_quorum_status | latest | group_by [], sum"
    }

  }

  chart {
    name = "OSDs OUT"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a-b)"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
with
  a = metric ceph_osd_up | latest | group_by [], count;
  b = metric ceph_osd_in | latest | group_by [], count;
join ((a - b)), a=0, b=0
EOT
    }

  }

  chart {
    name = "OSDs UP"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_osd_up | latest | group_by [], sum"
    }

  }

  chart {
    name = "OSDs IN"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_osd_in | latest | group_by [], sum"
    }

  }

  chart {
    name = "Avg PGs"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric ceph_osd_numpg | latest | group_by [], mean"
    }

  }

  chart {
    name = "Avg OSD Op Read Latency"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "(a/b)"
      display      = "line"
      hidden       = false
      query_string = <<EOT
with
  a = metric ceph_osd_op_r_latency_sum | rate 5m, 5m | group_by [], sum;
  b = metric ceph_osd_op_r_latency_count | rate 5m, 5m | group_by [], sum;
join ((a / b)), a=0, b=0 | reduce 5m, mean
EOT
    }

  }

}
