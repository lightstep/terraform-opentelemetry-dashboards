terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_elasticsearchreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry elasticsearchreceiver Integration"

    
    
    chart {
      name = "elasticsearch.cluster.data_nodes"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.cluster.data_nodes"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of data nodes in the cluster.
        # TODO: add unit: {nodes}
      }
    }
    
    chart {
      name = "elasticsearch.cluster.health"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.cluster.health"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "health_status"]
        }
        
        # TODO: add description: The health status of the cluster.
        # TODO: add unit: {status}
      }
    }
    
    chart {
      name = "elasticsearch.cluster.nodes"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.cluster.nodes"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The total number of nodes in the cluster.
        # TODO: add unit: {nodes}
      }
    }
    
    chart {
      name = "elasticsearch.cluster.shards"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.cluster.shards"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "shard_state"]
        }
        
        # TODO: add description: The number of shards in the cluster.
        # TODO: add unit: {shards}
      }
    }
    
    chart {
      name = "elasticsearch.node.cache.evictions"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.cache.evictions"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "cache_name"]
        }
        
        # TODO: add description: The number of evictions from the cache.
        # TODO: add unit: {evictions}
      }
    }
    
    chart {
      name = "elasticsearch.node.cache.memory.usage"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.cache.memory.usage"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "cache_name"]
        }
        
        # TODO: add description: The size in bytes of the cache.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "elasticsearch.node.cluster.connections"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.cluster.connections"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of open tcp connections for internal cluster communication.
        # TODO: add unit: {connections}
      }
    }
    
    chart {
      name = "elasticsearch.node.cluster.io"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.cluster.io"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "direction"]
        }
        
        # TODO: add description: The number of bytes sent and received on the network for internal cluster communication.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "elasticsearch.node.documents"
      rank = "8"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.documents"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "document_state"]
        }
        
        # TODO: add description: The number of documents on the node.
        # TODO: add unit: {documents}
      }
    }
    
    chart {
      name = "elasticsearch.node.fs.disk.available"
      rank = "9"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.fs.disk.available"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The amount of disk space available across all file stores for this node.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "elasticsearch.node.http.connections"
      rank = "10"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.http.connections"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of HTTP connections to the node.
        # TODO: add unit: {connections}
      }
    }
    
    chart {
      name = "elasticsearch.node.open_files"
      rank = "11"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.open_files"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of open file descriptors held by the node.
        # TODO: add unit: {files}
      }
    }
    
    chart {
      name = "elasticsearch.node.operations.completed"
      rank = "12"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.operations.completed"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "operation"]
        }
        
        # TODO: add description: The number of operations completed.
        # TODO: add unit: {operations}
      }
    }
    
    chart {
      name = "elasticsearch.node.operations.time"
      rank = "13"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.operations.time"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "operation"]
        }
        
        # TODO: add description: Time spent on operations.
        # TODO: add unit: ms
      }
    }
    
    chart {
      name = "elasticsearch.node.shards.size"
      rank = "14"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.shards.size"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The size of the shards assigned to this node.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "elasticsearch.node.thread_pool.tasks.finished"
      rank = "15"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.thread_pool.tasks.finished"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "thread_pool_name", "task_state"]
        }
        
        # TODO: add description: The number of tasks finished by the thread pool.
        # TODO: add unit: {tasks}
      }
    }
    
    chart {
      name = "elasticsearch.node.thread_pool.tasks.queued"
      rank = "16"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.thread_pool.tasks.queued"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "thread_pool_name"]
        }
        
        # TODO: add description: The number of queued tasks in the thread pool.
        # TODO: add unit: {tasks}
      }
    }
    
    chart {
      name = "elasticsearch.node.thread_pool.threads"
      rank = "17"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "elasticsearch.node.thread_pool.threads"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "thread_pool_name", "thread_state"]
        }
        
        # TODO: add description: The number of threads in the thread pool.
        # TODO: add unit: {threads}
      }
    }
    
    chart {
      name = "jvm.classes.loaded"
      rank = "18"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "jvm.classes.loaded"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of loaded classes
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "jvm.gc.collections.count"
      rank = "19"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "jvm.gc.collections.count"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "collector_name"]
        }
        
        # TODO: add description: The total number of garbage collections that have occurred
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "jvm.gc.collections.elapsed"
      rank = "20"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "jvm.gc.collections.elapsed"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "collector_name"]
        }
        
        # TODO: add description: The approximate accumulated collection elapsed time
        # TODO: add unit: ms
      }
    }
    
    chart {
      name = "jvm.memory.heap.committed"
      rank = "21"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "jvm.memory.heap.committed"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The amount of memory that is guaranteed to be available for the heap
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "jvm.memory.heap.max"
      rank = "22"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "jvm.memory.heap.max"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The maximum amount of memory can be used for the heap
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "jvm.memory.heap.used"
      rank = "23"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "jvm.memory.heap.used"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The current heap memory usage
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "jvm.memory.nonheap.committed"
      rank = "24"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "jvm.memory.nonheap.committed"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The amount of memory that is guaranteed to be available for non-heap purposes
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "jvm.memory.nonheap.used"
      rank = "25"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "jvm.memory.nonheap.used"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The current non-heap memory usage
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "jvm.memory.pool.max"
      rank = "26"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "jvm.memory.pool.max"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = [ "memory_pool_name"]
        }
        
        # TODO: add description: The maximum amount of memory can be used for the memory pool
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "jvm.memory.pool.used"
      rank = "27"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "jvm.memory.pool.used"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = [ "memory_pool_name"]
        }
        
        # TODO: add description: The current memory pool memory usage
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "jvm.threads.count"
      rank = "28"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "jvm.threads.count"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The current number of threads
        # TODO: add unit: 1
      }
    }
}