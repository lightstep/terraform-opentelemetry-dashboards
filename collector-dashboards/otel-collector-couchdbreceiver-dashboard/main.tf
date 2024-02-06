terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.89.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_couchdbreceiver_dashboard" {
  project_name   = var.lightstep_project
  dashboard_name = "CouchDB Receiver"

  chart {
    name = "CouchDB Average Request Time"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric couchdb.average_request_time | latest | group_by [], sum
EOT
    }
  }

  chart {
    name = "CouchDB Database Open"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric couchdb.database.open | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "CouchDB Database Operations"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric couchdb.database.operations | rate | group_by ["operation"], sum
EOT
    }
  }

  chart {
    name = "CouchDB File Descriptor Open"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric couchdb.file_descriptor.open | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "CouchDB HTTP Bulk Requests"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric couchdb.httpd.bulk_requests | rate | group_by [], sum
EOT
    }
  }

  chart {
    name = "CouchDB HTTP Requests"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric couchdb.httpd.requests | rate | group_by ["http.method"], sum
EOT
    }
  }

  chart {
    name = "CouchDB HTTP Responses"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric couchdb.httpd.responses | rate | group_by ["http.status_code"], sum
EOT
    }
  }

  chart {
    name = "CouchDB HTTP Views"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric couchdb.httpd.views | rate | group_by ["view"], sum
EOT
    }
  }
}
