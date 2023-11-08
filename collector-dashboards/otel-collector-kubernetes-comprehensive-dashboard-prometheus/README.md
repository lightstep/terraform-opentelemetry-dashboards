# Terraform Resource for Lightstep Kubernetes Comprehensive OpenTelemetry Dashboard (Prometheus)

This is a Terraform resource for a dashboard that monitors a Kubernetes cluster running an OpenTelemetry Collector that scrapes [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics) with a [prometheus receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/prometheusreceiver).

## How to Use This Module

1. Follow the instructions in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards) for basic setup of the Lightstep Terraform Provider.

1. Run `terraform init/plan/apply` as describe in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards).
