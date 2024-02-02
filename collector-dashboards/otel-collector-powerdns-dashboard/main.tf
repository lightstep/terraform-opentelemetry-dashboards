terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.88.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_powerdnsreceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "powerdnsreceiver Integration"
  dashboard_description = ""

  chart {
    name = "Queries Slower than a Second"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pdns_recursor_answers_slow | rate | group_by [], sum"
    }

  }

  chart {
    name = "Queries Faster than a Second"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pdns_recursor_answers100_1000 | rate | group_by [], sum"
    }

  }

  chart {
    name = "Cache hits since starting"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pdns_recursor_cache_hits | rate | group_by [], sum"
    }

  }

  chart {
    name = "Cache misses since starting"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pdns_recursor_cache_misses | rate | group_by [], sum"
    }

  }

  chart {
    name = "Entries in the cache"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric pdns_recursor_cache_entries | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Entries in the negative answers cache"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric pdns_recursor_negcache-entries | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Addresses in the failed NS cache"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric pdns_recursor_failed_host_entries | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "MThreads currently running"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pdns_recursor_concurrent_queries | latest | group_by [], sum"
    }

  }

  chart {
    name = "Entries in the throttle map"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pdns_recursor_throttle_entries | rate | group_by [], sum"
    }

  }

  chart {
    name = "Nameservers were unreachable since starting"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pdns_recursor_unreachables | rate | group_by [], sum"
    }

  }

  chart {
    name = "Queries chained to existing outstanding query"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pdns_recursor_chain_resends | rate | group_by [], sum"
    }

  }

  chart {
    name = "Mismatches in character case since starting"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric pdns_recursor_case_mismatches | rate | group_by [], sum"
    }

  }

}