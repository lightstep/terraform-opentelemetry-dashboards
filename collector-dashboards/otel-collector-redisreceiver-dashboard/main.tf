terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.60.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_redisreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry redisreceiver Integration"

    
    
    chart {
      name = "redis.clients.blocked"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.clients.blocked"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of clients pending on a blocking call
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.clients.connected"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.clients.connected"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of client connections (excluding connections from replicas)
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.clients.max_input_buffer"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.clients.max_input_buffer"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Biggest input buffer among current client connections
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.clients.max_output_buffer"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.clients.max_output_buffer"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Longest output list among current client connections
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.commands"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.commands"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of commands processed per second
        # TODO: add unit: {ops}/s
      }
    }
    
    chart {
      name = "redis.commands.processed"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.commands.processed"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Total number of commands processed by the server
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.connections.received"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.connections.received"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Total number of connections accepted by the server
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.connections.rejected"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.connections.rejected"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of connections rejected because of maxclients limit
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.cpu.time"
      rank = "8"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.cpu.time"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = [ "state"]
        }
        
        # TODO: add description: System CPU consumed by the Redis server in seconds since server start
        # TODO: add unit: s
      }
    }
    
    chart {
      name = "redis.db.avg_ttl"
      rank = "9"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.db.avg_ttl"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = [ "db"]
        }
        
        # TODO: add description: Average keyspace keys TTL
        # TODO: add unit: ms
      }
    }
    
    chart {
      name = "redis.db.expires"
      rank = "10"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.db.expires"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = [ "db"]
        }
        
        # TODO: add description: Number of keyspace keys with an expiration
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.db.keys"
      rank = "11"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.db.keys"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = [ "db"]
        }
        
        # TODO: add description: Number of keyspace keys
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.keys.evicted"
      rank = "12"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.keys.evicted"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of evicted keys due to maxmemory limit
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.keys.expired"
      rank = "13"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.keys.expired"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Total number of key expiration events
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.keyspace.hits"
      rank = "14"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.keyspace.hits"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of successful lookup of keys in the main dictionary
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.keyspace.misses"
      rank = "15"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.keyspace.misses"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of failed lookup of keys in the main dictionary
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.latest_fork"
      rank = "16"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.latest_fork"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Duration of the latest fork operation in microseconds
        # TODO: add unit: us
      }
    }
    
    chart {
      name = "redis.memory.fragmentation_ratio"
      rank = "17"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.memory.fragmentation_ratio"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Ratio between used_memory_rss and used_memory
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.memory.lua"
      rank = "18"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.memory.lua"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of bytes used by the Lua engine
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "redis.memory.peak"
      rank = "19"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.memory.peak"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Peak memory consumed by Redis (in bytes)
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "redis.memory.rss"
      rank = "20"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.memory.rss"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of bytes that Redis allocated as seen by the operating system
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "redis.memory.used"
      rank = "21"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.memory.used"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Total number of bytes allocated by Redis using its allocator
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "redis.net.input"
      rank = "22"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.net.input"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The total number of bytes read from the network
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "redis.net.output"
      rank = "23"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.net.output"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The total number of bytes written to the network
        # TODO: add unit: By
      }
    }
    
    chart {
      name = "redis.rdb.changes_since_last_save"
      rank = "24"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.rdb.changes_since_last_save"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of changes since the last dump
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.replication.backlog_first_byte_offset"
      rank = "25"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.replication.backlog_first_byte_offset"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The master offset of the replication backlog buffer
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.replication.offset"
      rank = "26"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.replication.offset"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The server's current replication offset
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.slaves.connected"
      rank = "27"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.slaves.connected"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of connected replicas
        # TODO: add unit: 
      }
    }
    
    chart {
      name = "redis.uptime"
      rank = "28"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "redis.uptime"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: Number of seconds since Redis server start
        # TODO: add unit: s
      }
    }
}