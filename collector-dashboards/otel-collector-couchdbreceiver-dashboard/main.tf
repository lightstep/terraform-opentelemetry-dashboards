terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.62.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_couchdbreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry couchdbreceiver Integration"

    
    
    chart {
      name = "couchdb.average_request_time"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "couchdb.average_request_time"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The average duration of a served request.
        # TODO: add unit: ms
      }
    }
    
    chart {
      name = "couchdb.database.open"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "couchdb.database.open"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of open databases.
        # TODO: add unit: {databases}
      }
    }
    
    chart {
      name = "couchdb.database.operations"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "couchdb.database.operations"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "operation"]
        }
        
        # TODO: add description: The number of database operations.
        # TODO: add unit: {operations}
      }
    }
    
    chart {
      name = "couchdb.file_descriptor.open"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "couchdb.file_descriptor.open"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of open file descriptors.
        # TODO: add unit: {files}
      }
    }
    
    chart {
      name = "couchdb.httpd.bulk_requests"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "couchdb.httpd.bulk_requests"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of bulk requests.
        # TODO: add unit: {requests}
      }
    }
    
    chart {
      name = "couchdb.httpd.requests"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "couchdb.httpd.requests"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "http.method"]
        }
        
        # TODO: add description: The number of HTTP requests by method.
        # TODO: add unit: {requests}
      }
    }
    
    chart {
      name = "couchdb.httpd.responses"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "couchdb.httpd.responses"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "http.status_code"]
        }
        
        # TODO: add description: The number of each HTTP status code.
        # TODO: add unit: {responses}
      }
    }
    
    chart {
      name = "couchdb.httpd.views"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "couchdb.httpd.views"
        timeseries_operator = "rate"

        group_by {
          aggregation_method = "sum"
          keys               = [ "view"]
        }
        
        # TODO: add description: The number of views read.
        # TODO: add unit: {views}
      }
    }
}