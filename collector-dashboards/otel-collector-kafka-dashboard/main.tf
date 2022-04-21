terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.60.2"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_kafka_dashboard" {
    project_name   = var.lightstep_project
    dashboard_name = "OpenTelemetry Collector - Kafka Metrics"

    chart {
      name = "Broker count"
      rank = "0"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "kafka.brokers"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = []
        }

        # TODO: Unit "{brokers}"
        # TODO: Number of brokers in the cluster.
      }
    }

    chart {
      name = "Kafka partitions per topic"
      rank = "1"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "kafka.topic.partitions"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["topic"]
        }
        # TODO: add description: Number of partitions in topic.
        # TODO: add unit: "{partitions}"
      }
    }

    chart {
      name = "Kafka partitions current offset"
      rank = "2"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "kafka.partition.current_offset"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["topic", "partition"]
        }
        # TODO: add description: Current offset of partition of topic.
        # TODO: add unit: 1
      }
    }

    chart {
      name = "Kafka partitions oldest offset"
      rank = "3"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "kafka.partition.oldest_offset"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["topic", "partition"]
        }
        # TODO: add description: Oldest offset of partition of topic
        # TODO: add unit: 1
      }
    }

    chart {
      name = "Kafka partition replicas"
      rank = "4"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "kafka.partition.replicas"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["topic", "partition"]
        }
        # TODO: add description: Number of replicas for partition of topic
        # TODO: add unit: "{replicas}"
      }
    }

    chart {
      name = "Kafka synchronized partition replicas"
      rank = "5"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "kafka.partition.replicas_in_sync"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["topic", "partition"]
        }
        # TODO: add description: Number of synchronized replicas of partition
        # TODO: add unit: "{replicas}"
      }
    }

    chart {
      name = "Kafka consumer group members"
      rank = "6"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "kafka.consumer_group.members"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["group"]
        }
        # TODO: add description: Count of members in the consumer group
        # TODO: add unit: "{members}"
      }
    }

    chart {
      name = "Kafka consumer group offset"
      rank = "7"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "kafka.consumer_group.offset"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["group", "topic", "partition"]
        }
        # TODO: add description: Current offset of the consumer group at partition of topic
        # TODO: add unit: 1
      }
    }

    chart {
      name = "Kafka consumer group offset sum"
      rank = "8"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "kafka.consumer_group.offset_sum"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["group", "topic"]
        }
        # TODO: add description: Sum of consumer group offset across partitions of topic
        # TODO: add unit: 1
      }
    }

    chart {
      name = "Kafka consumer group lag"
      rank = "9"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "kafka.consumer_group.lag"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["group", "topic", "partition"]
        }
        # TODO: add description: Current approximate lag of consumer group at partition of topic
        # TODO: add unit: 1
      }
    }

    chart {
      name = "Kafka consumer group lag sum"
      rank = "10"
      type = "timeseries"

      query {
        query_name = "a"
        display    = "line"
        hidden     = false

        metric              = "kafka.consumer_group.lag_sum"
        timeseries_operator = "last"

        group_by {
          aggregation_method = "sum"
          keys               = ["group", "topic"]
        }
        # TODO: add description: Current approximate sum of consumer group lag across all partitions of topic
        # TODO: add unit: 1
      }
    }
}