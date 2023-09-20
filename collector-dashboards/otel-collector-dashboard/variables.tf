variable "lightstep_project" {
  description = "Name of Cloud Observability project"
  type        = string
}


variable "dashboard_addons" {
  description = "List of addons to add to the dashboard. Available addons: \"prometheus\"."
  type        = list(string)
  default     = []
  validation {
    condition     = length(setsubtract(var.dashboard_addons, ["prometheus"])) == 0
    error_message = "Allowed values for dashboard_addons are: \"prometheus\"."
  }
}
