variable "lightstep_project" {
  description = "Name of Lightstep project"
  type        = string
}

variable "workloads" {
  description = "List of monitored workloads for creating dashboards"
  type = list(object({
    namespace = string
    workload  = string
  }))
}
