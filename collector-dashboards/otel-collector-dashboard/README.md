# Terraform Module for Lightstep OpenTelemetry Dashboards

**:warning:** You are viewing a **beta version** of the official
module to create and manage OpenTelemetry Integration Dashboards inside Lightstep.

This module provisions a Lightstep dashboard for monitoring a OpenTelemetry Collector.

The dashboard can be used to detect data loss, CPU/Memory saturation and details about data ingestion. A HATS (Hourly Active Time Series) graph is also included to monitor the effect of the ingested metrics.

For a more in-depth recommendation on how to monitor and alert on the OpenTelemetry Collector, please refer to the [documentation](https://github.com/open-telemetry/opentelemetry-collector/blob/main/docs/monitoring.md).


## How to Use This Module

1. Follow the instructions in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards) for basic setup of the Lightstep Terraform Provider.

1. Create a module in your `.tf` file for the OpenTelemetry dashbaord.

```
## Example: Create OpenTelemetry Collector Dashboard
module "otel-collector-dashboard" {
  source            = "./terraform-opentelemetry-dashboards/collector-dashboards/otel-collector-dashboard"
  lightstep_project = "dev-jkart"
}

## Example: expose your module outputs
output "otel_dash_module" {
  value = module.otel-collector-dashboard
}


```

1. Run `terraform init/plan/apply` as describe in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards).





# OpenTelemetry Collector Dashboard


