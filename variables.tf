variable "lightstep_project" {
  description = "Name of Cloud Observability project"
  type        = string
}

variable "lightstep_organization" {
  description = "Name of Cloud Observability organization"
  type        = string
}

variable "lightstep_env" {
  description = "Cloud Observability environment"
  type        = string
  default     = "public"
}

variable "lightstep_api_key_env_var" {
  description = "Name of the local environment variable that contains the Cloud Observability API key"
  type        = string
  default     = "LIGHTSTEP_API_KEY"
}
