terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.84.2"
    }
  }
  required_version = ">= v1.0.11"
}

variable "lightstep_project" {
  description = "Name of Cloud Observability project"
  type        = string
}

variable "lightstep_organization" {
  description = "Name of Cloud Observability organization"
  type        = string
}

variable "lightstep_api_key" {
  description = "Cloud Observability API Key"
  type        = string
}

provider "lightstep" {
  api_key      = var.lightstep_api_key
  organization = var.lightstep_organization
}

module "lightstep_k8s_kubelet_dashboard" {
  source                      = "github.com/lightstep/terraform-opentelemetry-dashboards//collector-dashboards/otel-collector-k8s-kubelet-prom-dashboard?ref=v1.76.0-20230606"
  lightstep_project = var.lightstep_project
}

module "lightstep_k8s_node_exporter_dashboard" {
  source                      = "github.com/lightstep/terraform-opentelemetry-dashboards//collector-dashboards/otel-collector-k8s-node-exporter-prom-dashboard?ref=v1.76.0-20230606"
  lightstep_project = var.lightstep_project
}

module "lightstep_k8s_pod_resources_dashboard" {
  source                      = "github.com/lightstep/terraform-opentelemetry-dashboards//collector-dashboards/otel-collector-k8s-pod-resources-prom-dashboard?ref=v1.76.0-20230606"
  lightstep_project = var.lightstep_project
}
