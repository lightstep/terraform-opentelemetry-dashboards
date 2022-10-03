terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.62.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_kubeletstatsreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry kubeletstatsreceiver Integration"

    
    
    chart {
      name = "cpu.time"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "cpu.time"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: CPU time
        # TODO: add unit: s
      }
    }
    
    chart {
      name = "cpu.utilization"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "cpu.utilization"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: CPU utilization
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "filesystem.available"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "filesystem.available"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Filesystem available
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "filesystem.capacity"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "filesystem.capacity"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Filesystem capacity
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "filesystem.usage"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "filesystem.usage"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Filesystem usage
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "memory.available"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memory.available"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Memory available
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "memory.major_page_faults"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memory.major_page_faults"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Memory major_page_faults
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "memory.page_faults"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memory.page_faults"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Memory page_faults
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "memory.rss"
      rank = "8"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memory.rss"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Memory rss
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "memory.usage"
      rank = "9"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memory.usage"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Memory usage
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "memory.working_set"
      rank = "10"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "memory.working_set"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Memory working_set
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "network.errors"
      rank = "11"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "network.errors"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "interface", "direction"]
        }
        
        # TODO: add description: Network errors
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "network.io"
      rank = "12"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "network.io"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "interface", "direction"]
        }
        
        # TODO: add description: Network IO
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "volume.available"
      rank = "13"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "volume.available"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of available bytes in the volume.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "volume.capacity"
      rank = "14"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "volume.capacity"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The total capacity in bytes of the volume.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "volume.inodes"
      rank = "15"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "volume.inodes"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The total inodes in the filesystem.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "volume.inodes.free"
      rank = "16"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "volume.inodes.free"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The free inodes in the filesystem.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "volume.inodes.used"
      rank = "17"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "volume.inodes.used"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The inodes used by the filesystem. This may not equal inodes - free because filesystem may share inodes with other filesystems.
        # TODO: add unit: 1
      }
    }
}