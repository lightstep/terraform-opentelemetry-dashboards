terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.62.0"
    }
  }
  required_version = ">= v1.0.11"
}
