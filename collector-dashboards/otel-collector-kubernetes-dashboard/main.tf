terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.86.1"
    }
  }
  required_version = ">= v1.0.11"
}
