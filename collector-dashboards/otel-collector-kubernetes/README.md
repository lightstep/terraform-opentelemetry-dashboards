# Terraform Module for Lightstep OpenTelemetry Dashboards

**:warning:** You are viewing a **beta version** of the official
module to create and manage OpenTelemetry Integration Dashboards inside Lightstep.

This is a Terraform module for deploying dashboards to monitor a Kubernetes cluster running an OpenTelemetry Collector scraping kube-state-metrics.


## How to Use This Module

1. Follow the instructions in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards) for basic setup of the Lightstep Terraform Provider.

1. Identify which Kubernetes workloads you would like to monitor.
    ```bash
    % kubectl get deployment,daemonset,statefulset -A | awk ‘{print $1 $2}’
    % kubectl get deployment,daemonset,statefulset -A -o jsonpath='{range .items[*]}namespace:{@.metadata.namespace} workload:{@.metadata.name}{"\n"}{end}'
    ```
1. Create a module in your `.tf` file for the Kubernetes dashbaords.
    ```
    ## Example: Create OpenTelemetry Kubernetes Dashboard
    module "kube-dashboards" {
      source            = "./terraform-opentelemetry-dashboards/collector-dashboards/otel-collector-kubernetes"
      lightstep_project = "dev-jkart"

      workloads = [
        {
          namespace = "cert-manager"
          workload  = "cert-manager"
        },
        {
          namespace = "kube-system"
          workload  = "fluentbit-gke"
        },
        {
          namespace = "kube-system"
          workload  = "gke-metrics-agent"
        },
        {
          namespace = "kube-system"
          workload  = "konnectivity-agent"
        },
        {
          namespace = "testapp"
          workload  = "testapp"
        },
        # more workloads here ...
      ]
    }

    ## Example: expose your module outputs
    output "kube_module" {
      value = module.kube-dashboards
    }


    ```
1. Run `terraform init/plan/apply` as describe in the [main readme](https://github.com/lightstep/terraform-opentelemetry-dashboards).
