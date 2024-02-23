terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.4"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_minio_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Minio"
  dashboard_description = "MinIO Dashboard - https://min.io/"

  chart {
    name = "Total S3 Traffic Inbound (Bytes)"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_s3_traffic_received_bytes | delta | group_by [], sum
EOT
    }

  }

  chart {
    name = "Capacity"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric minio_cluster_capacity_usable_free_bytes | latest | group_by ["service.instance.id"], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "area"
      hidden       = false
      query_string = <<EOT
metric minio_cluster_capacity_usable_total_bytes | latest | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Data Usage Growth"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_bucket_usage_total_bytes | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Object Size Distribution"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric minio_bucket_objects_size_distribution | rate | group_by ["range"], sum
EOT
    }

  }

  chart {
    name = "Total Open FDs"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_node_file_descriptor_open_total | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Total S3 Traffic Outbound (Bytes)"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_s3_traffic_sent_bytes | delta | group_by [], sum
EOT
    }

  }

  chart {
    name = "Total Goroutines"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_node_go_routine_total | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Total Online Servers"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_cluster_nodes_online_total | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Total Online Disks"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_cluster_disk_online_total | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Number of Buckets"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_bucket_usage_total_bytes | latest | group_by [], count
EOT
    }

  }

  chart {
    name = "S3 API Data Received"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_s3_traffic_received_bytes | rate | group_by ["server"], sum
EOT
    }

  }

  chart {
    name = "S3 API Data Sent"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_s3_traffic_sent_bytes | rate | group_by ["server"], sum
EOT
    }

  }

  chart {
    name = "Total Offline Servers"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_cluster_nodes_offline_total | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Total Offline Disks"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_cluster_disk_offline_total | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Number of Objects"
    rank = "14"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_bucket_usage_object_total | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Time Since Last Heal Activity (Seconds)"
    rank = "15"
    type = "timeseries"

    query {
      query_name   = "(a/1000000000)"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_heal_time_last_activity_nano_seconds | latest | group_by [], sum | point ((value /1000000000))
EOT
    }

  }

  chart {
    name = "Time Since Last Scan Activity (Seconds)"
    rank = "16"
    type = "timeseries"

    query {
      query_name   = "(a/1000000000)"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_usage_last_activity_nano_seconds | latest | group_by [], sum | point ((value /1000000000))
EOT
    }

  }

  chart {
    name = "S3 API Request"
    rank = "17"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_s3_requests_total | rate | group_by ["api", "server"], sum
EOT
    }

  }

  chart {
    name = "S3 API Request Error"
    rank = "18"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_s3_requests_errors_total | rate | group_by ["api", "server"], sum
EOT
    }

  }

  chart {
    name = "Bucket Traffic Sent"
    rank = "19"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_bucket_traffic_sent_bytes | latest | group_by ["bucket"], sum
EOT
    }

  }

  chart {
    name = "Bucket Traffic Received"
    rank = "20"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_bucket_traffic_received_bytes | latest | group_by ["bucket"], sum
EOT
    }

  }

  chart {
    name = "S3 API Request Error (5xx)"
    rank = "21"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric minio_s3_requests_5xx_errors_total | rate | group_by ["server", "api"], sum
EOT
    }

  }

  chart {
    name = "S3 API Request Error (4xx)"
    rank = "22"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric minio_s3_requests_4xx_errors_total | rate | group_by ["api", "server"], sum
EOT
    }

  }

  chart {
    name = "Internode Data Transfer"
    rank = "23"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric minio_inter_node_traffic_received_bytes | rate 1s | group_by [], sum
EOT
    }

  }

  chart {
    name = "Healing"
    rank = "24"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric minio_heal_objects_heal_total | latest | group_by ["service.instance.id"], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric minio_heal_objects_error_total | rate | group_by ["service.instance.id"], sum
EOT
    }

    query {
      query_name   = "c"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric minio_heal_objects_total | latest | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Node CPU Usage"
    rank = "25"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_node_process_cpu_total_seconds | rate | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Node Memory Usage"
    rank = "26"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_node_process_resident_memory_bytes | latest | group_by ["service.instance.id"], sum
EOT
    }

  }

  chart {
    name = "Drive Used Capacity"
    rank = "27"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_node_disk_used_bytes | latest | group_by ["disk", "server"], sum
EOT
    }

  }

  chart {
    name = "Drives Free Inodes"
    rank = "28"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_cluster_disk_free_inodes | rate | group_by ["server", "disk"], sum
EOT
    }

  }

  chart {
    name = "Node Syscalls"
    rank = "29"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_node_syscall_write_total | rate | group_by ["server"], sum
EOT
    }

  }

  chart {
    name = "Node File Descriptors"
    rank = "30"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_node_file_descriptor_open_total | latest | group_by ["server"], sum
EOT
    }

  }

  chart {
    name = "Node IO"
    rank = "31"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_node_io_rchar_bytes | rate | group_by ["server"], sum
EOT
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric minio_node_io_wchar_bytes | rate | group_by ["server"], sum
EOT
    }

  }

}
