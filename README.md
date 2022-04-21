# Terraform Module for Lightstep OpenTelemetry Dashboards

**:warning:** You are viewing a **beta version** of the official
module to create and manage OpenTelemetry Integration Dashboards inside Lightstep.

This is a Terraform module for deploying pre-defined set of OpenTelemetry Integration dashboards in Lightstep meant to be used with the OpenTelemetry Collector.

## Pre-requisites

* Lightstep account and API Key with `member` permissons.
* Terraform v1.0+


```
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

## Example: Create OpenTelemetry Collector Dashboard
module "collector-dashboards" {
  source            = "./collector-dashboards/otel-collector-dashboard"
  lightstep_project = "your project"
}

## Example: Create OpenTelemetry MySQL Integration Dashboard
module "collector-mysql-dashboards" {
  source            = "./collector-dashboards/otel-collector-mysql-dashboard"
  lightstep_project = "your project"
}

```