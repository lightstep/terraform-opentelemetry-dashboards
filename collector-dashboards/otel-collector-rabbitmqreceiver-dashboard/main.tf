terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.60.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_rabbitmqreceiver_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry rabbitmqreceiver Integration"

    
    
    chart {
      name = "rabbitmq.consumer.count"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "rabbitmq.consumer.count"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of consumers currently reading from the queue.
        # TODO: add unit: {consumers}
      }
    }
    
    chart {
      name = "rabbitmq.message.acknowledged"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "rabbitmq.message.acknowledged"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of messages acknowledged by consumers.
        # TODO: add unit: {messages}
      }
    }
    
    chart {
      name = "rabbitmq.message.current"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "rabbitmq.message.current"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = [ "message.state"]
        }
        
        # TODO: add description: The total number of messages currently in the queue.
        # TODO: add unit: {messages}
      }
    }
    
    chart {
      name = "rabbitmq.message.delivered"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "rabbitmq.message.delivered"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of messages delivered to consumers.
        # TODO: add unit: {messages}
      }
    }
    
    chart {
      name = "rabbitmq.message.dropped"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "rabbitmq.message.dropped"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of messages dropped as unroutable.
        # TODO: add unit: {messages}
      }
    }
    
    chart {
      name = "rabbitmq.message.published"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "rabbitmq.message.published"
        timeseries_operator = "rate"


        group_by {
          aggregation_method = "sum"
          keys               = []
        }
        
        # TODO: add description: The number of messages published to a queue.
        # TODO: add unit: {messages}
      }
    }
}