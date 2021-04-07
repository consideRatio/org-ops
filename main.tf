terraform {
  backend "gcs" {
    bucket = "two-eye-two-see-org-wide-terraform-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  region = var.region
}

resource "google_project" "fully_managed_project" {
  for_each = var.fully_managed_projects

  name            = each.key
  project_id      = each.key
  billing_account = each.value
  org_id          = var.org_id

  lifecycle {
    # NEVER DESTROY A PROJECT!
    prevent_destroy = true
  }
}

resource "google_project_iam_binding" "project_owners" {
  for_each = var.fully_managed_projects

  project = each.key
  # FIXME: Investigate if roles/editor is enough?
  role = "roles/owner"

  lifecycle {
    # NEVER DESTROY A PROJECT!
    prevent_destroy = true
  }

  members = var.project_owners
}

# GCS bucket for terraform state of all projects we manage
# If we need to, we can create ACLs later for per-object permissions,
# since terraform keeps each workspace in its own object
resource "google_storage_bucket" "managed_terraform_state" {
  name    = "${var.project_id}-terraform-state"
  project = var.project_id

  # Allows us to turn on ACLs in the future if necessary
  uniform_bucket_level_access = false

  versioning {
    enabled = true
  }

}
