# Terraform Module for Lightstep OpenTelemetry Dashboards

**:warning:** You are viewing a **beta version** of the official
module to create and manage OpenTelemetry Integration Dashboards inside Lightstep.

This module provisions a Lightstep dashboard for monitoring an OpenTelemetry Operator deployed on Kubernetes.

The dashboard can be used to visualize operator resource metrics and reconciliation performance.

---
## How to Use This Module

1. Follow the instructions in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards) for basic setup of the Lightstep Terraform Provider.

1. Create a module in your `.tf` file for the OpenTelemetry dashbaord.
    ```
    ## Example: Create OpenTelemetry Operator Dashboard
    module "otel-operator-dashboard" {
      source            = "./terraform-opentelemetry-dashboards/collector-dashboards/otel-operator-dashboard"
      lightstep_project = "dev-jkart"
    }

    ## Example: expose your module outputs
    output "otel_dash_module" {
      value = module.otel-operator-dashboard
    }
    ```
1. Run `terraform init/plan/apply` as describe in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards).
---