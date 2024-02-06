terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.89.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_elasticsearchreceiver_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "Elasticsearchreceiver Receiver"

  chart {
    name = "Elasticsearch Cluster Data Nodes"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.cluster.data_nodes | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Cluster Health"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.cluster.health | rate | group_by ["health_status"], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Cluster Nodes"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.cluster.nodes | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Cluster Shards"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.cluster.shards | rate | group_by ["shard_state"], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Cache Evictions"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.cache.evictions | rate | group_by ["cache_name"], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Cache Memory Usage"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.cache.memory.usage | rate | group_by ["cache_name"], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Cluster Connections"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.cluster.connections | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Cluster IO"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.cluster.io | rate | group_by ["direction"], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Documents"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.documents | rate | group_by ["document_state"], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node FS Disk Available"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.fs.disk.available | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node HTTP Connections"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.http.connections | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Open Files"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.open_files | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Operations Completed"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.operations.completed | rate | group_by ["operation"], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Operations Time"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.operations.time | rate | group_by ["operation"], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Shards Size"
    rank = "14"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.shards.size | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Thread Pool Tasks Finished"
    rank = "15"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.thread_pool.tasks.finished | rate | group_by ["thread_pool_name", "task_state"], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Thread Pool Tasks Queued"
    rank = "16"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.thread_pool.tasks.queued | rate | group_by ["thread_pool_name"], sum
EOT
    }
  }

  chart {
    name = "Elasticsearch Node Thread Pool Threads"
    rank = "17"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric elasticsearch.node.thread_pool.threads | rate | group_by ["thread_pool_name", "thread_state"], sum
EOT
    }
  }

  chart {
    name = "JVM Classes Loaded"
    rank = "18"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric jvm.classes.loaded | latest | group_by [], sum
EOT
    }
  }

  chart {
    name = "JVM GC Collections Count"
    rank = "19"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric jvm.gc.collections.count | rate | group_by ["collector_name"], sum
EOT
    }
  }

  chart {
    name = "JVM GC Collections Elapsed"
    rank = "20"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric jvm.gc.collections.elapsed | rate | group_by ["collector_name"], sum
EOT
    }
  }

  chart {
    name = "JVM Memory Heap Committed"
    rank = "21"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric jvm.memory.heap.committed | latest | group_by [], sum
EOT
    }
  }

  chart {
    name = "JVM Memory Heap Max"
    rank = "22"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric jvm.memory.heap.max | latest | group_by [], sum
EOT
    }
  }

  chart {
    name = "JVM Memory Heap Used"
    rank = "23"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric jvm.memory.heap.used | latest | group_by [], sum
EOT
    }
  }

  chart {
    name = "JVM Memory Nonheap Committed"
    rank = "24"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric jvm.memory.nonheap.committed | latest | group_by [], sum
EOT
    }
  }

  chart {
    name = "JVM Memory Nonheap Used"
    rank = "25"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric jvm.memory.nonheap.used | latest | group_by [], sum
EOT
    }
  }

  chart {
    name = "JVM Memory Pool Max"
    rank = "26"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric jvm.memory.pool.max | latest | group_by ["memory_pool_name"], sum
EOT
    }
  }

  chart {
    name = "JVM Memory Pool Used"
    rank = "27"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric jvm.memory.pool.used | latest | group_by ["memory_pool_name"], sum
EOT
    }
  }

  chart {
    name = "JVM Threads Count"
    rank = "28"
    type = "timeseries"

    query {
      query_name   = "a"
      hidden       = false
      display      = "line"
      query_string = <<EOT
metric jvm.threads.count | latest | group_by [], sum
EOT
    }
  }
}
