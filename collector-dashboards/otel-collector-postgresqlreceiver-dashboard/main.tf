terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.76.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_postgresql_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "PostgreSQL"
  dashboard_description = "PostgreSQL Dashboard"


  chart {
    name = "Index Scans"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.index.scans | rate | group_by ["postgresql.database.name", "postgresql.index.name", "postgresql.table.name"], sum
EOT
    }

  }

  chart {
    name = "Table Size"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric postgresql.table.size | latest | group_by ["postgresql.database.name", "postgresql.table.name"], sum
EOT
    }

  }

  chart {
    name = "Database Size"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric postgresql.db_size | latest | group_by ["postgresql.database.name"], sum
EOT
    }

  }

  chart {
    name = "Index Size"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.index.size | latest | group_by ["postgresql.index.name", "postgresql.database.name"], sum
EOT
    }

  }

  chart {
    name = "Commits"
    rank = "14"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.commits | rate | group_by ["postgresql.database.name"], sum
EOT
    }

  }

  chart {
    name = "Rows"
    rank = "15"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.rows | latest | group_by ["postgresql.database.name", "postgresql.table.name", "state"], sum
EOT
    }

  }

  chart {
    name = "Insert"
    rank = "16"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.operations | filter (operation == "ins") | rate | group_by ["database"], sum
EOT
    }

  }

  chart {
    name = "Update"
    rank = "17"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.operations | filter ((operation == "hot_upd") || (operation == "upd")) | rate | group_by ["postgresql.database.name", "postgresql.table.name"], sum
EOT
    }

  }

  chart {
    name = "Database Count"
    rank = "18"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric postgresql.database.count | latest | group_by [], sum"
    }

  }

  chart {
    name = "Backends"
    rank = "19"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric postgresql.backends | latest | group_by [], sum"
    }

  }

  chart {
    name = "Delete"
    rank = "20"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.operations | filter (operation == "del") | rate | group_by ["postgresql.database.name", "postgresql.table.name"], sum
EOT
    }

  }

  chart {
    name = "Blocks Read"
    rank = "21"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.blocks_read | rate | group_by ["postgresql.database.name", "postgresql.table.name", "source"], sum
EOT
    }

  }

  chart {
    name = "Rollbacks"
    rank = "22"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.rollbacks | rate | group_by ["postgresql.database.name"], sum
EOT
    }

  }

  chart {
    name = "Max Connections"
    rank = "23"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric postgresql.connection.max | latest | group_by [], sum"
    }

  }

  chart {
    name = "Allocated Buffers"
    rank = "25"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric postgresql.bgwriter.buffers.allocated | rate | group_by [], sum"
    }

  }

  chart {
    name = "Buffers Writes"
    rank = "26"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.bgwriter.buffers.writes | rate | group_by ["source"], sum
EOT
    }

  }

  chart {
    name = "Checkpoints"
    rank = "27"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.bgwriter.checkpoint.count | rate | group_by ["type"], sum
EOT
    }

  }

  chart {
    name = "Duration"
    rank = "28"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.bgwriter.duration | rate | group_by ["type"], sum
EOT
    }

  }

  chart {
    name = "Max written"
    rank = "29"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = <<EOT
metric postgresql.bgwriter.maxwritten | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Vacuum Count"
    rank = "30"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric postgresql.table.vacuum.count | rate | group_by ["postgresql.database.name", "postgresql.table.name"], sum
EOT
    }

  }

}
