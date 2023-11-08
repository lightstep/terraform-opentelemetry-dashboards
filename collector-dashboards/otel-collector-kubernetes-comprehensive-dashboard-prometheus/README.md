# Terraform Resource for Lightstep Kubernetes Comprehensive OpenTelemetry Dashboard (Prometheus)

This is a Terraform resource for a dashboard that monitors metrics outputted by the OpenTelemetry collectors set up with the `otel-cloud-stack` collector config.
This dashboard uses metrics with Prometheus semantic convention naming.

## How to Use This Module

1. Follow the instructions in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards) for basic setup of the Lightstep Terraform Provider.

1. Run `terraform init/plan/apply` as describe in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards).
