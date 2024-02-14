terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.1"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_mongoatlasreceiver_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "mongoatlasreceiver Integration"



  chart {
    name = "mongodbatlas.db.counts"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.db.counts"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["object_type"]
      }

      # TODO: add description: Database feature size
      # TODO: add unit: {objects}
    }
  }

  chart {
    name = "mongodbatlas.db.size"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.db.size"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["object_type"]
      }

      # TODO: add description: Database feature size
      # TODO: add unit: By
    }
  }

  chart {
    name = "mongodbatlas.disk.partition.iops.average"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.disk.partition.iops.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["disk_direction"]
      }

      # TODO: add description: Disk partition iops
      # TODO: add unit: {ops}/s
    }
  }

  chart {
    name = "mongodbatlas.disk.partition.iops.max"
    rank = "3"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.disk.partition.iops.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["disk_direction"]
      }

      # TODO: add description: Disk partition iops
      # TODO: add unit: {ops}/s
    }
  }

  chart {
    name = "mongodbatlas.disk.partition.latency.average"
    rank = "4"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.disk.partition.latency.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["disk_direction"]
      }

      # TODO: add description: Disk partition latency
      # TODO: add unit: ms
    }
  }

  chart {
    name = "mongodbatlas.disk.partition.latency.max"
    rank = "5"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.disk.partition.latency.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["disk_direction"]
      }

      # TODO: add description: Disk partition latency
      # TODO: add unit: ms
    }
  }

  chart {
    name = "mongodbatlas.disk.partition.space.average"
    rank = "6"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.disk.partition.space.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["disk_status"]
      }

      # TODO: add description: Disk partition space
      # TODO: add unit: By
    }
  }

  chart {
    name = "mongodbatlas.disk.partition.space.max"
    rank = "7"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.disk.partition.space.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["disk_status"]
      }

      # TODO: add description: Disk partition space
      # TODO: add unit: By
    }
  }

  chart {
    name = "mongodbatlas.disk.partition.usage.average"
    rank = "8"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.disk.partition.usage.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["disk_status"]
      }

      # TODO: add description: Disk partition usage (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.disk.partition.usage.max"
    rank = "9"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.disk.partition.usage.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["disk_status"]
      }

      # TODO: add description: Disk partition usage (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.disk.partition.utilization.average"
    rank = "10"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.disk.partition.utilization.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["disk_status"]
      }

      # TODO: add description: Disk partition utilization (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.disk.partition.utilization.max"
    rank = "11"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.disk.partition.utilization.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["disk_status"]
      }

      # TODO: add description: Disk partition utilization (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.asserts"
    rank = "12"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.asserts"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["assert_type"]
      }

      # TODO: add description: Number of assertions per second
      # TODO: add unit: {assertions}/s
    }
  }

  chart {
    name = "mongodbatlas.process.background_flush"
    rank = "13"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.background_flush"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Amount of data flushed in the background
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.cache.io"
    rank = "14"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.cache.io"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cache_direction"]
      }

      # TODO: add description: Cache throughput (per second)
      # TODO: add unit: By
    }
  }

  chart {
    name = "mongodbatlas.process.cache.size"
    rank = "15"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.cache.size"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["cache_status"]
      }

      # TODO: add description: Cache sizes
      # TODO: add unit: By
    }
  }

  chart {
    name = "mongodbatlas.process.connections"
    rank = "16"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.connections"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Number of current connections
      # TODO: add unit: {connections}
    }
  }

  chart {
    name = "mongodbatlas.process.cpu.children.normalized.usage.average"
    rank = "17"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.cpu.children.normalized.usage.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: CPU Usage for child processes, normalized to pct
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.cpu.children.normalized.usage.max"
    rank = "18"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.cpu.children.normalized.usage.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: CPU Usage for child processes, normalized to pct
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.cpu.children.usage.average"
    rank = "19"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.cpu.children.usage.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: CPU Usage for child processes (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.cpu.children.usage.max"
    rank = "20"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.cpu.children.usage.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: CPU Usage for child processes (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.cpu.normalized.usage.average"
    rank = "21"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.cpu.normalized.usage.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: CPU Usage, normalized to pct
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.cpu.normalized.usage.max"
    rank = "22"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.cpu.normalized.usage.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: CPU Usage, normalized to pct
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.cpu.usage.average"
    rank = "23"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.cpu.usage.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: CPU Usage (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.cpu.usage.max"
    rank = "24"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.cpu.usage.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: CPU Usage (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.cursors"
    rank = "25"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.cursors"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cursor_state"]
      }

      # TODO: add description: Number of cursors
      # TODO: add unit: {cursors}
    }
  }

  chart {
    name = "mongodbatlas.process.db.document.rate"
    rank = "26"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.db.document.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["document_status"]
      }

      # TODO: add description: Document access rates
      # TODO: add unit: {documents}/s
    }
  }

  chart {
    name = "mongodbatlas.process.db.operations.rate"
    rank = "27"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.db.operations.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["operation", "cluster_role"]
      }

      # TODO: add description: DB Operation Rates
      # TODO: add unit: {operations}/s
    }
  }

  chart {
    name = "mongodbatlas.process.db.operations.time"
    rank = "28"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.db.operations.time"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["execution_type"]
      }

      # TODO: add description: DB Operation Times
      # TODO: add unit: ms
    }
  }

  chart {
    name = "mongodbatlas.process.db.query_executor.scanned"
    rank = "29"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.db.query_executor.scanned"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["scanned_type"]
      }

      # TODO: add description: Scanned objects
      # TODO: add unit: {objects}/s
    }
  }

  chart {
    name = "mongodbatlas.process.db.query_targeting.scanned_per_returned"
    rank = "30"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.db.query_targeting.scanned_per_returned"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["scanned_type"]
      }

      # TODO: add description: Scanned objects per returned
      # TODO: add unit: {scanned}/{returned}
    }
  }

  chart {
    name = "mongodbatlas.process.db.storage"
    rank = "31"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.db.storage"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["storage_status"]
      }

      # TODO: add description: Storage used by the database
      # TODO: add unit: By
    }
  }

  chart {
    name = "mongodbatlas.process.fts.cpu.usage"
    rank = "32"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.fts.cpu.usage"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: Full text search CPU (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.global_lock"
    rank = "33"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.global_lock"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["global_lock_state"]
      }

      # TODO: add description: Number and status of locks
      # TODO: add unit: {locks}
    }
  }

  chart {
    name = "mongodbatlas.process.index.btree_miss_ratio"
    rank = "34"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.index.btree_miss_ratio"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Index miss ratio (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.process.index.counters"
    rank = "35"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.index.counters"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["btree_counter_type"]
      }

      # TODO: add description: Indexes
      # TODO: add unit: {indexes}
    }
  }

  chart {
    name = "mongodbatlas.process.journaling.commits"
    rank = "36"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.journaling.commits"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Journaling commits
      # TODO: add unit: {commits}
    }
  }

  chart {
    name = "mongodbatlas.process.journaling.data_files"
    rank = "37"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.journaling.data_files"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Data file sizes
      # TODO: add unit: MiBy
    }
  }

  chart {
    name = "mongodbatlas.process.journaling.written"
    rank = "38"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.journaling.written"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Journals written
      # TODO: add unit: MiBy
    }
  }

  chart {
    name = "mongodbatlas.process.memory.usage"
    rank = "39"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.memory.usage"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["memory_state"]
      }

      # TODO: add description: Memory Usage
      # TODO: add unit: By
    }
  }

  chart {
    name = "mongodbatlas.process.network.io"
    rank = "40"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.network.io"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction"]
      }

      # TODO: add description: Network IO
      # TODO: add unit: By/s
    }
  }

  chart {
    name = "mongodbatlas.process.network.requests"
    rank = "41"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.network.requests"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Network requests
      # TODO: add unit: {requests}
    }
  }

  chart {
    name = "mongodbatlas.process.oplog.rate"
    rank = "42"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.oplog.rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Execution rate by operation
      # TODO: add unit: GiBy/h
    }
  }

  chart {
    name = "mongodbatlas.process.oplog.time"
    rank = "43"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.oplog.time"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["oplog_type"]
      }

      # TODO: add description: Execution time by operation
      # TODO: add unit: s
    }
  }

  chart {
    name = "mongodbatlas.process.page_faults"
    rank = "44"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.page_faults"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["memory_issue_type"]
      }

      # TODO: add description: Page faults
      # TODO: add unit: {faults}/s
    }
  }

  chart {
    name = "mongodbatlas.process.restarts"
    rank = "45"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.restarts"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Restarts in last hour
      # TODO: add unit: {restarts}/h
    }
  }

  chart {
    name = "mongodbatlas.process.tickets"
    rank = "46"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.process.tickets"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["ticket_type"]
      }

      # TODO: add description: Tickets
      # TODO: add unit: {tickets}
    }
  }

  chart {
    name = "mongodbatlas.system.cpu.normalized.usage.average"
    rank = "47"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.cpu.normalized.usage.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: System CPU Normalized to pct
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.system.cpu.normalized.usage.max"
    rank = "48"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.cpu.normalized.usage.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: System CPU Normalized to pct
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.system.cpu.usage.average"
    rank = "49"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.cpu.usage.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: System CPU Usage (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.system.cpu.usage.max"
    rank = "50"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.cpu.usage.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: System CPU Usage (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.system.fts.cpu.normalized.usage"
    rank = "51"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.fts.cpu.normalized.usage"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: Full text search disk usage (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.system.fts.cpu.usage"
    rank = "52"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.fts.cpu.usage"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["cpu_state"]
      }

      # TODO: add description: Full-text search (%)
      # TODO: add unit: 1
    }
  }

  chart {
    name = "mongodbatlas.system.fts.disk.used"
    rank = "53"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.fts.disk.used"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: Full text search disk usage
      # TODO: add unit: By
    }
  }

  chart {
    name = "mongodbatlas.system.fts.memory.usage"
    rank = "54"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.fts.memory.usage"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["memory_state"]
      }

      # TODO: add description: Full-text search
      # TODO: add unit: MiBy
    }
  }

  chart {
    name = "mongodbatlas.system.memory.usage.average"
    rank = "55"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.memory.usage.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["memory_status"]
      }

      # TODO: add description: System Memory Usage
      # TODO: add unit: KiBy
    }
  }

  chart {
    name = "mongodbatlas.system.memory.usage.max"
    rank = "56"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.memory.usage.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["memory_status"]
      }

      # TODO: add description: System Memory Usage
      # TODO: add unit: KiBy
    }
  }

  chart {
    name = "mongodbatlas.system.network.io.average"
    rank = "57"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.network.io.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction"]
      }

      # TODO: add description: System Network IO
      # TODO: add unit: By/s
    }
  }

  chart {
    name = "mongodbatlas.system.network.io.max"
    rank = "58"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.network.io.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction"]
      }

      # TODO: add description: System Network IO
      # TODO: add unit: By/s
    }
  }

  chart {
    name = "mongodbatlas.system.paging.io.average"
    rank = "59"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.paging.io.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction"]
      }

      # TODO: add description: Swap IO
      # TODO: add unit: {pages}/s
    }
  }

  chart {
    name = "mongodbatlas.system.paging.io.max"
    rank = "60"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.paging.io.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction"]
      }

      # TODO: add description: Swap IO
      # TODO: add unit: {pages}/s
    }
  }

  chart {
    name = "mongodbatlas.system.paging.usage.average"
    rank = "61"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.paging.usage.average"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction"]
      }

      # TODO: add description: Swap usage
      # TODO: add unit: KiBy
    }
  }

  chart {
    name = "mongodbatlas.system.paging.usage.max"
    rank = "62"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "mongodbatlas.system.paging.usage.max"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction"]
      }

      # TODO: add description: Swap usage
      # TODO: add unit: KiBy
    }
  }
}