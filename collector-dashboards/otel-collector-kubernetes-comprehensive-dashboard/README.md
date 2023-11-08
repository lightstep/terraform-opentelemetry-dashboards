# Terraform Resource for Lightstep Kubernetes Comprehensive OpenTelemetry Dashboard

This is a Terraform resource for a dashboard for monitoring Kubernetes metrics outputted by the OpenTelemetry collectors set up with the [otel-cloud-stack](https://github.com/lightstep/otel-collector-charts/tree/main/charts/otel-cloud-stack) collector config, which includes the [k8sclusterreceiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/k8sclusterreceiver) and [kubeletstatsreceiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/kubeletstatsreceiver). 

## How to Use This Module

1. Follow the instructions in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards) for basic setup of the Lightstep Terraform Provider.

1. Run `terraform init/plan/apply` as describe in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards).
