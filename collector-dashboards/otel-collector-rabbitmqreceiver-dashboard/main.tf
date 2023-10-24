terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.84.2"
    }
  }
  required_version = ">= v1.0.11"
}


resource "lightstep_dashboard" "otel_collector_rabbitmqreceiver_dashboard" {
  project_name          = var.lightstep_project
  dashboard_name        = "RabbitMQ Dashboard"
  dashboard_description = "Monitor RabbitMQ with this message metrics summary."

  chart {
    name = "Consumer Count"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric rabbitmq.consumer.count | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Message Acknowledged"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric rabbitmq.message.acknowledged | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Message Current"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric rabbitmq.message.current | rate | group_by ["message.state"], sum
EOT
    }

  }

  chart {
    name = "Message Delivered"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric rabbitmq.message.delivered | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Message Dropped"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric rabbitmq.message.dropped | rate | group_by [], sum
EOT
    }

  }

  chart {
    name = "Message Published"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric rabbitmq.message.published | rate | group_by [], sum
EOT
    }

  }

}
