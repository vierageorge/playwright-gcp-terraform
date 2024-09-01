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
  repository_id = var.repository_id
  location      = var.region
  format        = "DOCKER"
  description   = "Docker repository"
}

resource "google_storage_bucket" "general-logs-bucket" {
  name     = var.bucket_name
  location = var.region
}

output "bucket_url" {
  value = google_storage_bucket.general-logs-bucket.url
}


resource "google_cloudbuild_trigger" "my-test-trigger" {
  name     = "my-test-trigger"
  location = var.region
  webhook_config {
    secret = ""
  }
  lifecycle {
    ignore_changes = [ webhook_config ]
  }
  service_account = "projects/my-tests-372402/serviceAccounts/gh-actions-push@my-tests-372402.iam.gserviceaccount.com"
  build {
    step {
      name = "us-west2-docker.pkg.dev/my-tests-372402/test-repository/e2e-test-base"
      dir = "/app"
    }
    logs_bucket = google_storage_bucket.general-logs-bucket.name
  }
}