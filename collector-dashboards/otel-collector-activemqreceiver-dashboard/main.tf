terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.86.1"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_activemq_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "ActiveMQ"
  dashboard_description = "Monitor ActiveMQ with this summary dashboard."

  chart {
    name = "Producers"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric activemq.producer.count | latest | group_by [], max"
    }

  }

  chart {
    name = "Consumers"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "big_number"
      hidden       = false
      query_string = "metric activemq.consumer.count | latest | group_by [], max"
    }

  }

  chart {
    name = "ActiveMQ broker: store, memory and temp usage (in %)"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric activemq.disk.store_usage | latest | group_by [], sum"
    }

    query {
      query_name   = "b"
      display      = "line"
      hidden       = false
      query_string = "metric activemq.disk.temp_usage | latest | group_by [], sum"
    }

    query {
      query_name   = "c"
      display      = "line"
      hidden       = false
      query_string = "metric activemq.memory.usage | latest | group_by [], sum"
    }

  }

  chart {
    name = "Enqueue time"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = "metric activemq.message.wait_time.avg | latest | group_by [], sum"
    }

  }

  chart {
    name = "Dequeue count"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric activemq.message.dequeued | delta | group_by [], sum"
    }

  }

  chart {
    name = "Dispatch count"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric activemq.message.current | reduce mean | group_by [], sum"
    }

  }

  chart {
    name = "Enqueue count"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = <<EOT
metric activemq.message.enqueued | filter (type == "broker") | delta | group_by [], sum
EOT
    }

  }

  chart {
    name = "Expired count"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "bar"
      hidden       = false
      query_string = "metric activemq.message.expired | delta | group_by [], sum"
    }

  }

}
