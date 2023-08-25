# Terraform Module for Cloud Observability OpenTelemetry Dashboards

**:warning:** You are viewing a **beta version** of the official
module to create and manage OpenTelemetry Integration Dashboards inside Cloud Observability.

This module provisions a Cloud Observability dashboard for monitoring an OpenTelemetry Collector deployed on Kubernetes.

The dashboard can be used to detect data loss, CPU/Memory saturation and details about data ingestion. A HATS (Hourly Active Time Series) graph is also included to monitor the effect of the ingested metrics.

For a more in-depth recommendation on how to monitor and alert on the OpenTelemetry Collector, please refer to the [documentation](https://github.com/open-telemetry/opentelemetry-collector/blob/main/docs/monitoring.md).

---
## How to Use This Module

1. Follow the instructions in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards) for basic setup of the Cloud Observability Terraform Provider.

1. Create a module in your `.tf` file for the OpenTelemetry dashboard.
    ```
    ## Example: Create OpenTelemetry Collector Dashboard
    module "otel-collector-dashboard" {
      source            = "./terraform-opentelemetry-dashboards/collector-dashboards/otel-collector-dashboard"
      cloud_observability_project = "dev-jkart"
    }

    ## Example: expose your module outputs
    output "otel_dash_module" {
      value = module.otel-collector-dashboard
    }
    ```
1. Run `terraform init/plan/apply` as describe in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards).
---
## Dashboard Addons

OpenTelemetry Collector is a very extensible system in which one can define a specific set of receivers, processors and exporters to be enabled. Dashboards Addons are a way to customize this dashboad with charts that are specific for enabled components.

----
### Prometheus Receiver
Name: `prometheus`

Purpose: charts for monitoring [prometheus-receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/prometheusreceiver) performance. 