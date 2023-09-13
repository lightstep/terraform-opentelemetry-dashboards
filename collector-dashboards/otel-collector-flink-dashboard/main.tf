terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_flink_dashboard" {
  project_name          = var.cloud_observability_project
  dashboard_name        = "Flink - Overview"
  dashboard_description = "A high-level overview of Flink JobManagers and TaskManagers so you can monitor metrics related to jobs, memory, and checkpoints."

  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"

    chart {
      name   = "Running Jobs"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric flink_jobmanager_numRunningJobs | reduce mean | group_by [], mean"
      }
    }
    chart {
      name   = "Input Buffer Usage (%)"
      type   = "timeseries"
      rank   = 1
      x_pos  = 16
      y_pos  = 24
      width  = 16
      height = 8

      query {
        query_name   = "(a*100)"
        display      = "line"
        hidden       = false
        query_string = "metric flink_taskmanager_job_task_buffers_inPoolUsage | latest | group_by [\"task_id\", \"subtask_index\"], mean | point ((value *100))"
      }
    }
    chart {
      name   = "Full Restarts"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric flink_jobmanager_job_numRestarts | reduce mean | group_by [], sum"
      }
    }
    chart {
      name   = "Avg Job Uptime"
      type   = "timeseries"
      rank   = 3
      x_pos  = 0
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric flink_jobmanager_job_uptime | reduce mean | group_by [], mean"
      }
    }
    chart {
      name   = "Output Buffer Usage (%)"
      type   = "timeseries"
      rank   = 4
      x_pos  = 16
      y_pos  = 32
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric flink_taskmanager_job_task_buffers_outPoolUsage | reduce mean | group_by [\"task_id\", \"subtask_index\"], sum"
      }
    }
    chart {
      name   = "TaskManager Count"
      type   = "timeseries"
      rank   = 5
      x_pos  = 32
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric flink_jobmanager_numRegisteredTaskManagers | reduce mean | group_by [], sum"
      }
    }
    chart {
      name   = "Avg Job Downtime"
      type   = "timeseries"
      rank   = 6
      x_pos  = 0
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric flink_jobmanager_job_downtime | reduce mean | group_by [], mean"
      }
    }
    chart {
      name   = "Completed Checkpoints"
      type   = "timeseries"
      rank   = 7
      x_pos  = 16
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric flink_jobmanager_job_numberOfCompletedCheckpoints | reduce mean | group_by [], sum"
      }
    }
    chart {
      name   = "Failed Checkpoints"
      type   = "timeseries"
      rank   = 8
      x_pos  = 16
      y_pos  = 8
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric flink_jobmanager_job_numberOfFailedCheckpoints | reduce mean | group_by [], sum"
      }
    }
    chart {
      name   = "Outgoing Records Per Second"
      type   = "timeseries"
      rank   = 9
      x_pos  = 0
      y_pos  = 24
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric flink_taskmanager_job_task_numRecordsOut | reduce mean | group_by [\"task_id\"], sum"
      }
    }
    chart {
      name   = "TaskManager Heap Memory Usage (Bytes)"
      type   = "timeseries"
      rank   = 10
      x_pos  = 32
      y_pos  = 24
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric flink_taskmanager_Status_JVM_Memory_Heap_Used | reduce mean | group_by [\"tm_id\"], sum"
      }
    }
    chart {
      name   = "TaskManager CPU Load (%)"
      type   = "timeseries"
      rank   = 11
      x_pos  = 32
      y_pos  = 16
      width  = 16
      height = 8

      query {
        query_name   = "(a*100)"
        display      = "area"
        hidden       = false
        query_string = "metric flink_taskmanager_Status_JVM_CPU_Load | reduce mean | group_by [\"tm_id\"], sum | point ((value *100))"
      }
    }
    chart {
      name   = "TaskManager Garbage Collection Time (ms)"
      type   = "timeseries"
      rank   = 12
      x_pos  = 32
      y_pos  = 32
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "area"
        hidden       = false
        query_string = "metric flink_taskmanager_Status_JVM_GarbageCollector_G1_Young_Generation_Time | reduce mean | group_by [\"tm_id\"], sum"
      }
      query {
        query_name   = "b"
        display      = "area"
        hidden       = false
        query_string = "metric flink_taskmanager_Status_JVM_GarbageCollector_G1_Old_Generation_Time | reduce mean | group_by [\"tm_id\"], sum"
      }
    }
    chart {
      name   = "Last Checkpoint Completion Time (ms)"
      type   = "timeseries"
      rank   = 13
      x_pos  = 0
      y_pos  = 32
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric flink_jobmanager_job_lastCheckpointDuration | reduce mean | group_by [\"job_id\"], sum"
      }
    }
    chart {
      name   = "In Progress Checkpoints"
      type   = "timeseries"
      rank   = 14
      x_pos  = 16
      y_pos  = 0
      width  = 16
      height = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric flink_jobmanager_job_numberOfInProgressCheckpoints | reduce mean | group_by [], sum"
      }
    }
  }
}
