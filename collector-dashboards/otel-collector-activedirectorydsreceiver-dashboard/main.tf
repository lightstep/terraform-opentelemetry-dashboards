terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_activedirectorydsreceiver_dashboard" {
  project_name   = var.cloud_observability_project
  dashboard_name = "Active Directory ds receiver Integration"



  chart {
    name = "active_directory.ds.bind.rate"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.bind.rate"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["bind_type"]
      }

      # TODO: add description: The number of binds per second serviced by this domain controller.
      # TODO: add unit: {binds}/s
    }
  }

  chart {
    name = "active_directory.ds.ldap.bind.last_successful.time"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.ldap.bind.last_successful.time"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The amount of time taken for the last successful LDAP bind.
      # TODO: add unit: ms
    }
  }

  chart {
    name = "active_directory.ds.ldap.bind.rate"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.ldap.bind.rate"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The number of successful LDAP binds per second.
      # TODO: add unit: {binds}/s
    }
  }

  chart {
    name = "active_directory.ds.ldap.client.session.count"
    rank = "3"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.ldap.client.session.count"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The number of connected LDAP client sessions.
      # TODO: add unit: {sessions}
    }
  }

  chart {
    name = "active_directory.ds.ldap.search.rate"
    rank = "4"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.ldap.search.rate"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The number of LDAP searches per second.
      # TODO: add unit: {searches}/s
    }
  }

  chart {
    name = "active_directory.ds.name_cache.hit_rate"
    rank = "5"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.name_cache.hit_rate"
      timeseries_operator = "last"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The percentage of directory object name component lookups that are satisfied by the Directory System Agent's name cache.
      # TODO: add unit: %
    }
  }

  chart {
    name = "active_directory.ds.notification.queued"
    rank = "6"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.notification.queued"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The number of pending update notifications that have been queued to push to clients.
      # TODO: add unit: {notifications}
    }
  }

  chart {
    name = "active_directory.ds.operation.rate"
    rank = "7"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.operation.rate"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["operation_type"]
      }

      # TODO: add description: The number of operations performed per second.
      # TODO: add unit: {operations}/s
    }
  }

  chart {
    name = "active_directory.ds.replication.network.io"
    rank = "8"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.replication.network.io"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction", "network_data_type"]
      }

      # TODO: add description: The amount of network data transmitted by the Directory Replication Agent.
      # TODO: add unit: By
    }
  }

  chart {
    name = "active_directory.ds.replication.object.rate"
    rank = "9"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.replication.object.rate"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction"]
      }

      # TODO: add description: The number of objects transmitted by the Directory Replication Agent per second.
      # TODO: add unit: {objects}/s
    }
  }

  chart {
    name = "active_directory.ds.replication.operation.pending"
    rank = "10"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.replication.operation.pending"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The number of pending replication operations for the Directory Replication Agent.
      # TODO: add unit: {operations}
    }
  }

  chart {
    name = "active_directory.ds.replication.property.rate"
    rank = "11"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.replication.property.rate"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction"]
      }

      # TODO: add description: The number of properties transmitted by the Directory Replication Agent per second.
      # TODO: add unit: {properties}/s
    }
  }

  chart {
    name = "active_directory.ds.replication.sync.object.pending"
    rank = "12"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.replication.sync.object.pending"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The number of objects remaining until the full sync completes for the Directory Replication Agent.
      # TODO: add unit: {objects}
    }
  }

  chart {
    name = "active_directory.ds.replication.sync.request.count"
    rank = "13"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.replication.sync.request.count"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["sync_result"]
      }

      # TODO: add description: The number of sync requests made by the Directory Replication Agent.
      # TODO: add unit: {requests}
    }
  }

  chart {
    name = "active_directory.ds.replication.value.rate"
    rank = "14"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.replication.value.rate"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["direction", "value_type"]
      }

      # TODO: add description: The number of values transmitted by the Directory Replication Agent per second.
      # TODO: add unit: {values}/s
    }
  }

  chart {
    name = "active_directory.ds.security_descriptor_propagations_event.queued"
    rank = "15"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.security_descriptor_propagations_event.queued"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The number of security descriptor propagation events that are queued for processing.
      # TODO: add unit: {events}
    }
  }

  chart {
    name = "active_directory.ds.suboperation.rate"
    rank = "16"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.suboperation.rate"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = ["suboperation_type"]
      }

      # TODO: add description: The rate of sub-operations performed.
      # TODO: add unit: {suboperations}/s
    }
  }

  chart {
    name = "active_directory.ds.thread.count"
    rank = "17"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "active_directory.ds.thread.count"
      timeseries_operator = "rate"

      group_by {
        aggregation_method = "sum"
        keys               = []
      }

      # TODO: add description: The number of threads in use by the directory service.
      # TODO: add unit: {threads}
    }
  }
}