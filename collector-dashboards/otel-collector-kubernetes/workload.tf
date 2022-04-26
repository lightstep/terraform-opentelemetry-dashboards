locals {
  pod_owner_regex = "(-[bcdfghjklmnpqrstvwxz2456789]{3}[bcdfghjklmnpqrstvwxz2456789]{3}[bcdfghjklmnpqrstvwxz2456789]{4})?$"
}


resource "lightstep_metric_dashboard" "k8s_compute_resources_workload" {
  project_name   = var.lightstep_project
  count          = length(var.workloads)
  dashboard_name = "Kubernetes / Compute Resources / Workload / ${var.workloads[count.index].workload}"

  chart {
    name = "CPU Usage"
    rank = 1
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
with
cpu =
  fetch container_cpu_usage_seconds_total
  | rate
  | filter image =~ ".+" && container =~ ".+"
  | filter namespace = "${var.workloads[count.index].namespace}"
  | group_by [pod, namespace], sum;

owner =
  fetch kube_pod_owner
  | filter owner_name =~ "${var.workloads[count.index].workload}${local.pod_owner_regex}"
  | latest;

join cpu * owner
| group_by [pod, namespace, owner_kind, owner_name], sum
EOT
    }


    query {
      hidden     = false
      query_name = "b"
      display    = "line"
      tql        = <<EOT
with
request =
  fetch kube_pod_container_resource_requests
  | filter resource == "cpu"
  | reduce 1m, max
  | filter container =~ ".+"
  | filter namespace = "${var.workloads[count.index].namespace}"
  | group_by [pod, namespace], sum;

owner =
  fetch kube_pod_owner
  | filter owner_name =~ "${var.workloads[count.index].workload}${local.pod_owner_regex}"
  | latest;

join request * owner
| group_by [pod, namespace, owner_kind, owner_name], sum
EOT
    }

  }

  chart {
    name = "Memory Usage [MB]"
    rank = 2
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
with
mem =
  fetch container_memory_working_set_bytes
  | latest
  | filter image =~ ".+" && container =~ ".+"
  | filter namespace = "${var.workloads[count.index].namespace}"
  | group_by [pod, namespace], sum;

owner =
  fetch kube_pod_owner
  | filter owner_name =~ "${var.workloads[count.index].workload}${local.pod_owner_regex}"
  | latest;

join mem * owner / 1024 /1024
| group_by [pod, namespace, owner_kind, owner_name], sum
EOT
    }

    query {
      hidden     = false
      query_name = "b"
      display    = "line"
      tql        = <<EOT
with
request =
  fetch kube_pod_container_resource_requests
  | filter resource == "memory"
  | reduce 1m, max
  | filter container =~ ".+"
  | filter namespace = "${var.workloads[count.index].namespace}"
  | group_by [pod, namespace], sum;

owner =
  fetch kube_pod_owner
  | filter owner_name =~ "${var.workloads[count.index].workload}${local.pod_owner_regex}"
  | latest;

join request * owner / 1024 /1024
| group_by [pod, namespace, owner_kind, owner_name], sum
EOT
    }
  }

  chart {
    name = "Receive Bandwidth [KB/s]"
    rank = 3
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
with
net_rx =
  fetch container_network_receive_bytes_total
  | rate
  | filter image =~ ".+"
  | filter namespace = "${var.workloads[count.index].namespace}"
  | group_by [pod, namespace], sum;

owner =
  fetch kube_pod_owner
  | filter owner_name =~ "${var.workloads[count.index].workload}${local.pod_owner_regex}"
  | latest;

join net_rx * owner / 1024
| group_by [pod, namespace, owner_kind, owner_name], sum
EOT
    }
  }

  chart {
    name = "Transmit Bandwidth [KB/s]"
    rank = 4
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
with
net_tx=
  fetch container_network_transmit_bytes_total
  | rate
  | filter image =~ ".+"
  | filter namespace = "${var.workloads[count.index].namespace}"
  | group_by [pod, namespace], sum;

owner =
  fetch kube_pod_owner
  | filter owner_name =~ "${var.workloads[count.index].workload}${local.pod_owner_regex}"
  | latest;

join net_tx*owner / 1024
| group_by [pod, namespace, owner_kind, owner_name], sum
EOT
    }
  }

  chart {
    name = "Rate of Received Packets"
    rank = 5
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
with
pkt_rx =
  fetch container_network_receive_packets_total
  | rate
  | filter image =~ ".+"
  | filter namespace = "${var.workloads[count.index].namespace}"
  | group_by [pod, namespace], sum;

owner =
  fetch kube_pod_owner
  | filter owner_name =~ "${var.workloads[count.index].workload}${local.pod_owner_regex}"
  | latest;

join pkt_rx * owner
| group_by [pod, namespace, owner_kind, owner_name], sum
EOT
    }
  }

  chart {
    name = "Rate of Transmitted Packets"
    rank = 6
    type = "timeseries"

    query {
      hidden     = false
      query_name = "a"
      display    = "line"
      tql        = <<EOT
with
pkt_tx=
  fetch container_network_transmit_packets_total
  | rate
  | filter image =~ ".+"
  | filter namespace = "${var.workloads[count.index].namespace}"
  | group_by [pod, namespace], sum;


owner =
  fetch kube_pod_owner
  | filter owner_name =~ "${var.workloads[count.index].workload}${local.pod_owner_regex}"
  | latest;

join pkt_tx * owner
| group_by [pod, namespace, owner_kind, owner_name], sum
EOT
    }
  }
}


