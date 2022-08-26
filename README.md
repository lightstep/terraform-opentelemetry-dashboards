# Terraform Module for Lightstep OpenTelemetry Dashboards

**:warning:** You are viewing a **beta version** of the official
module to create and manage OpenTelemetry Integration Dashboards inside Lightstep.

This is a Terraform module for deploying pre-defined set of OpenTelemetry Integration dashboards in Lightstep meant to be used with the OpenTelemetry Collector.

## Pre-requisites

* Lightstep account and API Key with `member` permissons.
* Terraform v1.0+


## How to Use This Module

To deploy create Lightstep dashboards for production using this repo:

- Ensure account meets module pre-requisites from above.

- Create a Terraform configuration that pulls module(s) and specifies values
  of the required variables.

- Run `terraform init` and `terraform apply` with your API Key set in the environment variable `LIGHTSTEP_API_KEY` (or the environment variable name you specified in configuration).


## Examples

The following shows an example Terraform configuration for various integrations:
<details>
  <summary>OpenTelemetry Apache Tomcat Integration Dashboard</summary>

  ```yaml
  terraform {
    required_providers {
      lightstep = {
        source = "lightstep/lightstep"
        version = "1.60.2"
      }
    }
  }

  provider "lightstep" {
    api_key         = "your api key"
    organization    = "your organization"
  }

  module "collector-tomcat-dashboards" {
    source            = "./collector-dashboards/otel-collector-tomcat-dashboard"
    lightstep_project = "your project"
  }
  ```

</details>
<details>
  <summary>OpenTelemetry Collector Dashboard</summary>

  ```yaml
  terraform {
    required_providers {
      lightstep = {
        source = "lightstep/lightstep"
        version = "1.60.2"
      }
    }
  }

  provider "lightstep" {
    api_key         = "your api key"
    organization    = "your organization"
  }

  module "collector-dashboards" {
    source            = "./collector-dashboards/otel-collector-dashboard"
    lightstep_project = "your project"
  }
  ```

</details>
<details>
  <summary>OpenTelemetry Host Integration Dashboard</summary>

  ```yaml
  terraform {
    required_providers {
      lightstep = {
        source = "lightstep/lightstep"
        version = "1.60.2"
      }
    }
  }

  provider "lightstep" {
    api_key         = "your api key"
    organization    = "your organization"
  }

  module "collector-host-dashboards" {
    source            = "./collector-dashboards/otel-collector-host-dashboard"
    lightstep_project = "your project"
  }
  ```

</details>
<details>
  <summary>OpenTelemetry Host Metrics CPU Integration Dashboard</summary>

  ```yaml
  terraform {
    required_providers {
      lightstep = {
        source = "lightstep/lightstep"
        version = "1.60.2"
      }
    }
  }

  provider "lightstep" {
    api_key         = "your api key"
    organization    = "your organization"
  }

  module "collector-hostmetrics-cpu-dashboards" {
    source            = "./collector-dashboards/otel-collector-hostmetrics-cpu-dashboard"
    lightstep_project = "your project"
  }
  ```

</details>
<details>
  <summary>OpenTelemetry Host Metrics Memory Integration Dashboard</summary>

  ```yaml
  terraform {
    required_providers {
      lightstep = {
        source = "lightstep/lightstep"
        version = "1.60.2"
      }
    }
  }

  provider "lightstep" {
    api_key         = "your api key"
    organization    = "your organization"
  }

  module "collector-hostmetrics-memory-dashboards" {
    source            = "./collector-dashboards/otel-collector-hostmetrics-memory-dashboard"
    lightstep_project = "your project"
  }
  ```

</details>
<details>
  <summary>OpenTelemetry Host Metrics Disk Integration Dashboard</summary>

  ```yaml
  terraform {
    required_providers {
      lightstep = {
        source = "lightstep/lightstep"
        version = "1.60.2"
      }
    }
  }

  provider "lightstep" {
    api_key         = "your api key"
    organization    = "your organization"
  }

  module "collector-hostmetrics-disk-dashboards" {
    source            = "./collector-dashboards/otel-collector-hostmetrics-disk-dashboard"
    lightstep_project = "your project"
  }
  ```

</details>
<details>
  <summary>OpenTelemetry Host Metrics Paging Integration Dashboard</summary>

  ```yaml
  terraform {
    required_providers {
      lightstep = {
        source = "lightstep/lightstep"
        version = "1.60.2"
      }
    }
  }

  provider "lightstep" {
    api_key         = "your api key"
    organization    = "your organization"
  }

  module "collector-hostmetrics-paging-dashboards" {
    source            = "./collector-dashboards/otel-collector-hostmetrics-paging-dashboard"
    lightstep_project = "your project"
  }
  ```

</details>
<details>
  <summary>OpenTelemetry Kubernetes Dashboard</summary>

Visit Lightstep to [Learn how to send telemetry from an OpenTelemetry Collector to Lightstep using the Kubernetes Operator for OpenTelemetry](https://docs.lightstep.com/paths/collector-operator-path).

  ```yaml
  terraform {
    required_providers {
      lightstep = {
        source = "lightstep/lightstep"
        version = "1.60.2"
      }
    }
  }

  provider "lightstep" {
    api_key         = "your api key"
    organization    = "your organization"
  }

  module "kube-dashboards" {
    source            = "./terraform-opentelemetry-dashboards/collector-dashboards/otel-collector-kubernetes-dashboard"
    lightstep_project = "your project"

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
      }
    ]
  }

  ## Example: expose your module outputs
  output "kube_module" {
    value = module.kube-dashboards
  }
  ```

</details>
<details>
  <summary>OpenTelemetry MySQL Integration Dashboard</summary>

  ```yaml
  terraform {
    required_providers {
      lightstep = {
        source = "lightstep/lightstep"
        version = "1.60.2"
      }
    }
  }

  provider "lightstep" {
    api_key         = "your api key"
    organization    = "your organization"
  }

  module "collector-mysql-dashboards" {
    source            = "./collector-dashboards/otel-collector-mysql-dashboard"
    lightstep_project = "your project"
  }
  ```

</details>
<details>
  <summary>OpenTelemetry Redis Integration Dashboard</summary>


  ```yaml
  terraform {
    required_providers {
      lightstep = {
        source = "lightstep/lightstep"
        version = "1.60.2"
      }
    }
  }

  provider "lightstep" {
    api_key         = "your api key"
    organization    = "your organization"
  }

  module "collector-redisreceiver-dashboards" {
    source            = "./collector-dashboards/otel-collector-redisreceiver-dashboard"
    lightstep_project = "your project"
  }
  ```

</details>


