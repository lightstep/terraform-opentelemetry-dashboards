variable "cloud_observability_project" {
  description = "Name of Cloud Observability project"
  type        = string
}

variable "cloud_observability_organization" {
  description = "Name of Cloud Observability organization"
  type        = string
}

variable "cloud_observability_env" {
  description = "Cloud Observability environment"
  type        = string
  default     = "public"
}

variable "cloud_observability_api_key_env_var" {
  description = "Name of the local environment variable that contains the Cloud Observability API key"
  type        = string
  default     = "LIGHTSTEP_API_KEY"
}
