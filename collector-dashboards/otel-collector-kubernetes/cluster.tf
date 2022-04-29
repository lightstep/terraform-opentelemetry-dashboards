
resource "lightstep_metric_dashboard" "k8s_compute_resources_cluster" {
  project_name   = var.lightstep_project
  dashboard_name = "Kubernetes / Compute Resources / Cluster"



  chart {
    name = "% CPU Usage [BN]"
    rank = 1
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      // at the moment, the provider does not fully support big number display types.
      // We need the ability to pass the query_aggregation_options (https://github.com/lightstep/lightstep/pull/30470/files)
      // For right now, I'm setting this to "line" and we can adjust in the ui.
      // Eventually, this should look like:
      //  display = "big_number"
      //  query_aggregation_options {
      //    time_window_aggregation_method = "latest"
      //  }

      display = "line"
      tql     = <<EOT
with
cpu =
  fetch node_cpu_seconds_total
  | filter mode!="idle" && mode!="iowait" && mode!="steal"
  | rate 5m
  | group_by [], sum;

cpu_total =
  fetch node_cpu_seconds_total
  | rate
  | group_by [net.host.name, cpu], sum
  | group_by [], count;

join cpu / cpu_total * 100
| group_by [], sum
EOT
    }
  }


  chart {
    name = "% CPU Comitted [BN]"
    rank = 2
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      // at the moment, the provider does not fully support big number display types.
      // We need the ability to pass the query_aggregation_options (https://github.com/lightstep/lightstep/pull/30470/files)
      // For right now, I'm setting this to "line" and we can adjust in the ui.
      // Eventually, this should look like:
      //  display = "big_number"
      //  query_aggregation_options {
      //    time_window_aggregation_method = "mean"
      //  }

      display = "line"
      tql     = <<EOT
with

alloctable =
fetch kube_node_status_allocatable
| filter resource == "cpu"
| latest
| group_by [], sum;

request =
fetch kube_pod_container_resource_requests
| filter resource == "cpu"
| reduce 1m, max
| group_by[namespace, pod, container], max;


running_pods =
fetch kube_pod_status_phase
| reduce 1m, max
| filter phase=="Pending"|| phase == "Running"
| group_by [pod], sum;

join (request * running_pods) / alloctable * 100
| group_by [], sum


EOT
    }
  }

  chart {
    name = "% CPU Limit [BN]"
    rank = 3
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      // at the moment, the provider does not fully support big number display types.
      // We need the ability to pass the query_aggregation_options (https://github.com/lightstep/lightstep/pull/30470/files)
      // For right now, I'm setting this to "line" and we can adjust in the ui.
      // Eventually, this should look like:
      //  display = "big_number"
      //  query_aggregation_options {
      //    time_window_aggregation_method = "mean"
      //  }

      display = "line"
      tql     = <<EOT
with

alloctable =
fetch kube_node_status_allocatable
| filter resource == "cpu"
| latest
| group_by [], sum;

request =
fetch kube_pod_container_resource_limits
| filter resource == "cpu"
| reduce 1m, max
| group_by[namespace, pod, container], max;


running_pods =
fetch kube_pod_status_phase
| reduce 1m, max
| filter phase=="Pending"|| phase == "Running"
| group_by [pod], sum;

join (request * running_pods) / alloctable * 100
| group_by [], sum




EOT
    }
  }

  chart {
    name = "% Mem Usage [BN]"
    rank = 4
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      // at the moment, the provider does not fully support big number display types.
      // We need the ability to pass the query_aggregation_options (https://github.com/lightstep/lightstep/pull/30470/files)
      // For right now, I'm setting this to "line" and we can adjust in the ui.
      // Eventually, this should look like:
      //  display = "big_number"
      //  query_aggregation_options {
      //    time_window_aggregation_method = "latest"
      //  }

      display = "line"
      tql     = <<EOT
# 1 - sum(:node_memory_MemAvailable_bytes:sum{cluster="$cluster"}) / sum(node_memory_MemTotal_bytes{job="node-exporter",cluster="$cluster"})


with
mem =
  fetch node_memory_MemAvailable_bytes
  | latest
  | group_by [], sum;

mem_total =
  fetch node_memory_MemTotal_bytes
  | latest
  | group_by [], sum;

join 100 - (mem / mem_total * 100)
| group_by [], sum


EOT
    }
  }

  chart {
    name = "% Mem Comitted [BN]"
    rank = 5
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      // at the moment, the provider does not fully support big number display types.
      // We need the ability to pass the query_aggregation_options (https://github.com/lightstep/lightstep/pull/30470/files)
      // For right now, I'm setting this to "line" and we can adjust in the ui.
      // Eventually, this should look like:
      //  display = "big_number"
      //  query_aggregation_options {
      //    time_window_aggregation_method = "mean"
      //  }

      display = "line"
      tql     = <<EOT
with

alloctable =
fetch kube_node_status_allocatable
| filter resource == "memory"
| latest
| group_by [], sum;

request =
fetch kube_pod_container_resource_requests
| filter resource == "memory"
| reduce 1m, max
| group_by[namespace, pod, container], max;


running_pods =
fetch kube_pod_status_phase
| reduce 1m, max
| filter phase=="Pending"|| phase == "Running"
| group_by [pod], sum;

join (request * running_pods) / alloctable * 100
| group_by [], sum


EOT
    }
  }

  chart {
    name = "% Mem Limit [BN]"
    rank = 6
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      // at the moment, the provider does not fully support big number display types.
      // We need the ability to pass the query_aggregation_options (https://github.com/lightstep/lightstep/pull/30470/files)
      // For right now, I'm setting this to "line" and we can adjust in the ui.
      // Eventually, this should look like:
      //  display = "big_number"
      //  query_aggregation_options {
      //    time_window_aggregation_method = "mean"
      //  }

      display = "line"
      tql     = <<EOT
with

alloctable =
fetch kube_node_status_allocatable
| filter resource == "memory"
| latest
| group_by [], sum;

request =
fetch kube_pod_container_resource_limits
| filter resource == "memory"
| reduce 1m, max
| group_by[namespace, pod, container], max;


running_pods =
fetch kube_pod_status_phase
| reduce 1m, max
| filter phase=="Pending"|| phase == "Running"
| group_by [pod], sum;

join (request * running_pods) / alloctable * 100
| group_by [], sum


EOT
    }
  }


  chart {
    name = "CPU Usage"
    rank = 7
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
fetch container_cpu_usage_seconds_total
| rate
| filter image =~ ".+" && container =~ ".+"
| group_by [namespace], sum
EOT
    }
  }

  chart {
    name = "Memory Usage [MB]"
    rank = 8
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
fetch container_memory_working_set_bytes
| latest
| filter image =~ ".+" && container =~ ".+"
| group_by [namespace], sum
EOT
    }
  }

  chart {
    name = "Receive Bandwidth [KB/s]"
    rank = 9
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
fetch container_network_receive_bytes_total
| rate
| filter image =~ ".+"
| group_by [namespace], sum
EOT
    }
  }

  chart {
    name = "Transmit Bandwidth [KB/s]"
    rank = 10
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
fetch container_network_transmit_bytes_total
| rate
| filter image =~ ".+"
| group_by [namespace], sum
EOT
    }
  }

  chart {
    name = "Rate of Received Packets"
    rank = 11
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
fetch container_network_receive_packets_total
| rate
| filter image =~ ".+"
| group_by [namespace], sum
EOT
    }
  }

  chart {
    name = "Rate of Transmitted Packets"
    rank = 12
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
fetch container_network_transmit_packets_total
| rate
| filter image =~ ".+"
| group_by [namespace], sum
EOT
    }
  }

  chart {
    name = "IOPS (Reads + Writes)"
    rank = 13
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
with
  reads = metric container_fs_reads_total
  | rate
  | filter job="kubelet" &&
        metrics_path="/metrics/cadvisor" &&
        container =~".+" &&
        device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|dasd.+)" &&
        namespace=~".+"
  | group_by [namespace],sum;
  writes = metric container_fs_writes_total
  | rate
  | filter job="kubelet" &&
        metrics_path="/metrics/cadvisor" &&
        container =~".+" &&
        device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|dasd.+)" &&
        namespace=~".+"
  | group_by [namespace],sum;

join reads+writes
| group_by [namespace], sum
EOT
    }
  }

  chart {
    name = "Throughput (Reads + Writes)"
    rank = 14
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
with
  reads = metric container_fs_reads_bytes_total
  | rate
  | filter job="kubelet" &&
        metrics_path="/metrics/cadvisor" &&
        container =~".+" &&
        device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|dasd.+)" &&
        namespace=~".+"
  | group_by [namespace],sum;
  writes = metric container_fs_writes_bytes_total
  | rate
  | filter job="kubelet" &&
        metrics_path="/metrics/cadvisor" &&
        container =~".+" &&
        device=~"(/dev/)?(mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|dasd.+)" &&
        namespace=~".+"
  | group_by [namespace],sum;

join reads+writes
| group_by [namespace], sum
EOT
    }
  }
}


