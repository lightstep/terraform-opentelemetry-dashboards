terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.84.1"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_solr_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "Solr Overview Dashboard"
  dashboard_description = "Monitor Solr metrics with the OTel Collector's jmx receiver."

  chart {
    name = "Cache Evictions Count"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric solr.cache.eviction.count | rate 1m | group_by [], sum
EOT
    }

  }

  chart {
    name = "Cache Hit Count"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric solr.cache.hit.count | rate 1m | group_by [], sum
EOT
    }

  }

  chart {
    name = "Cache Insert Count"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric solr.cache.insert.count | rate 1m | group_by [], sum
EOT
    }

  }

  chart {
    name = "Cache Lookup Count"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric solr.cache.lookup.count | rate 1m | group_by [], sum
EOT
    }

  }

  chart {
    name = "Cache Size"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric solr.cache.size | delta | group_by [], sum
EOT
    }

  }

  chart {
    name = "Document Count"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric solr.document.count | latest | group_by [], sum
EOT
    }

  }

  chart {
    name = "Index Size"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric solr.index.size | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Request Count"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric solr.request.count | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Request Error Count"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric solr.request.error.count | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Request Time Average"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric solr.request.time.average | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Request Timeout Count"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric solr.request.timeout.count | rate | group_by [], sum
EOT
    }

  }

}
