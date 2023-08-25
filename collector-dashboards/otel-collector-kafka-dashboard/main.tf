terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_kafka_dashboard" {
  project_name          = var.cloud_observability_project
  dashboard_name        = "OpenTelemetry Collector - Kafka Metrics"
  dashboard_description = "Monitor Kafka with this metrics overview dashboard."

  chart {
    name = "Broker Count"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kafka.brokers | latest | group_by [], sum
EOT
    }
  }

  chart {
    name = "Kafka Partitions Per Topic"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kafka.topic.partitions | latest | group_by ["topic"], sum
EOT
    }
  }

  chart {
    name = "Kafka Partitions Current Offset"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kafka.partition.current_offset | latest | group_by ["topic", "partition"], sum
EOT
    }
  }

  chart {
    name = "Kafka Partitions Oldest Offset"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kafka.partition.oldest_offset | latest | group_by ["topic", "partition"], sum
EOT
    }
  }

  chart {
    name = "Kafka Partition Replicas"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kafka.partition.replicas | latest | group_by ["topic", "partition"], sum
EOT
    }
  }

  chart {
    name = "Kafka Synchronized Partition Replicas"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kafka.partition.replicas_in_sync | latest | group_by ["topic", "partition"], sum
EOT
    }
  }

  chart {
    name = "Kafka Consumer Group Members"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kafka.consumer_group.members | latest | group_by ["group"], sum
EOT
    }
  }

  chart {
    name = "Kafka Consumer Group Offset"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kafka.consumer_group.offset | latest | group_by ["group", "topic", "partition"], sum
EOT
    }
  }

  chart {
    name = "Kafka Consumer Group Offset Sum"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kafka.consumer_group.offset_sum | latest | group_by ["group", "topic"], sum
EOT
    }
  }

  chart {
    name = "Kafka Consumer Group Lag"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kafka.consumer_group.lag | latest | group_by ["group", "topic", "partition"], sum
EOT
    }
  }

  chart {
    name = "Kafka Consumer Group Lag Sum"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric kafka.consumer_group.lag_sum | latest | group_by ["group", "topic"], sum
EOT
    }
  }
}

