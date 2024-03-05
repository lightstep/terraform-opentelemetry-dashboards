terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.7"
    }
  }
  required_version = ">= v1.0.11"
}
