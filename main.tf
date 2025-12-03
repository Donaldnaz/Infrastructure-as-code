resource "google_project_iam_custom_role" "terraform_deployer" {
  role_id     = "terraformCustomDeployer"
  title       = "Terraform Deployer"
  description = "Custom role for Terraform deployments"
  permissions = [
    # Core permissions
    "resourcemanager.projects.get",
    "iam.serviceAccounts.create",
    "iam.serviceAccounts.delete",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.update",

    # Cloud Run permissions
    "run.services.create",
    "run.services.update",
    "run.services.get",
    "run.services.delete",

    # Cloud Functions permissions
    "cloudfunctions.functions.create",
    "cloudfunctions.functions.get",
    "cloudfunctions.functions.update",
    "cloudfunctions.functions.delete",

    # GKE permissions
    #"container.clusters.create",
    #"container.clusters.get",
    #"container.clusters.update",
    #"container.clusters.delete",

    # Vertex AI permissions
    "aiplatform.endpoints.create",
    "aiplatform.endpoints.get",
    "aiplatform.endpoints.update",
    "aiplatform.endpoints.delete",

    # Compute Engine permissions
    "compute.instances.create",
    "compute.instances.get",
    "compute.instances.update",
    "compute.instances.delete",

    # VPC permissions
    "compute.networks.create",
    "compute.networks.get",
    "compute.networks.update",
    "compute.networks.delete",

    # Storage permissions
    "storage.buckets.create",
    "storage.buckets.get",
    "storage.buckets.update",
    "storage.buckets.delete"
  ]
}

# IAM bindings for service accounts
resource "google_project_iam_binding" "terraform_sa_binding" {
  project = var.gcp_project_id
  role    = google_project_iam_custom_role.terraform_deployer.id
  members = [
    "serviceAccount:${var.terraform_sa_email}"
  ]
}

resource "google_project_iam_binding" "cloudrun_sa_binding" {
  project = var.gcp_project_id
  role    = "roles/run.admin"
  members = [
    "serviceAccount:${var.cloudrun_sa_email}"
  ]
}

resource "google_project_iam_binding" "cloudrun_sa_artifact_read" {
  project = var.gcp_project_id
  role    = "roles/artifactregistry.reader"
  members = [
    "serviceAccount:${var.cloudrun_sa_email}"
  ]
}

resource "google_project_iam_binding" "function_sa_binding" {
  project = var.gcp_project_id
  role    = "roles/cloudfunctions.admin"
  members = [
    "serviceAccount:${var.function_sa_email}"
  ]
}

resource "google_project_iam_binding" "function_sa_iam_user" {
  project = var.gcp_project_id
  role    = "roles/iam.serviceAccountUser"
  members = [
    "serviceAccount:${var.function_sa_email}",
    "serviceAccount:${var.cloudrun_sa_email}"
  ]
}

resource "google_project_iam_binding" "function_sa_event_receive" {
  project = var.gcp_project_id
  role    = "roles/eventarc.eventReceiver"
  members = [
    "serviceAccount:${var.function_sa_email}"
  ]
}

resource "google_project_iam_binding" "function_sa_storage_admin" {
  project = var.gcp_project_id
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:${var.function_sa_email}",
    "serviceAccount:${var.cloudrun_sa_email}"
  ]
}

resource "google_project_iam_binding" "function_sa_storage_viewer" {
  project = var.gcp_project_id
  role    = "roles/storage.objectViewer"
  members = [
    "serviceAccount:${var.function_sa_email}",
    "serviceAccount:${var.cloudrun_sa_email}"
  ]
}

/*
resource "google_project_iam_binding" "gke_sa_binding" {
  project = var.gcp_project_id
  role    = "roles/container.admin"
  members = [
    "serviceAccount:${var.gke_sa_email}"
  ]
}
*/
resource "google_project_iam_member" "gcs_pubsub_publisher" {
  project = var.gcp_project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-451817590527@gs-project-accounts.iam.gserviceaccount.com"
}