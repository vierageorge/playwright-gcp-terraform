terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.project
}

resource "google_artifact_registry_repository" "test-repository" {
  repository_id = "test-repository"
  location      = var.region
  format        = "DOCKER"
  description   = "Docker repository"
}