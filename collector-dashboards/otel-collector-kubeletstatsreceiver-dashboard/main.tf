terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.10"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_kubeletstatsreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry kubeletstatsreceiver Integration"

    
    
    chart {
      name = "container.cpu.time"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "container.cpu.time"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: CPU time
        # TODO: add unit: s
      }
    }
    
    chart {
      name = "container.cpu.utilization"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "container.cpu.utilization"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: CPU utilization
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "container.filesystem.available"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "container.filesystem.available"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: Filesystem available
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "container.filesystem.capacity"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "container.filesystem.capacity"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: Filesystem capacity
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "container.filesystem.usage"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "container.filesystem.usage"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: Filesystem usage
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "container.memory.available"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "container.memory.available"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: Memory available
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "container.memory.major_page_faults"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "container.memory.major_page_faults"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: Memory major_page_faults
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "container.memory.page_faults"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "container.memory.page_faults"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: Memory page_faults
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "container.memory.rss"
      rank = "8"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "container.memory.rss"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: Memory rss
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "container.memory.usage"
      rank = "9"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "container.memory.usage"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: Memory usage
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "container.memory.working_set"
      rank = "10"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "container.memory.working_set"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: Memory working_set
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "k8s.pod.network.errors"
      rank = "11"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "k8s.pod.network.errors"
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
      name = "k8s.pod.network.io"
      rank = "12"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "k8s.pod.network.io"
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
      name = "k8s.volume.available"
      rank = "13"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "k8s.volume.available"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: The number of available bytes in the volume.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "k8s.volume.capacity"
      rank = "14"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "k8s.volume.capacity"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: The total capacity in bytes of the volume.
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "k8s.volume.inodes"
      rank = "15"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "k8s.volume.inodes"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: The total inodes in the filesystem.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "k8s.volume.inodes.free"
      rank = "16"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "k8s.volume.inodes.free"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: The free inodes in the filesystem.
        # TODO: add unit: 1
      }
    }
    
    chart {
      name = "k8s.volume.inodes.used"
      rank = "17"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "k8s.volume.inodes.used"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["k8s.pod.name", "k8s.namespace.name"]
        }
        
        # TODO: add description: The inodes used by the filesystem. This may not equal inodes - free because filesystem may share inodes with other filesystems.
        # TODO: add unit: 1
      }
    }
}