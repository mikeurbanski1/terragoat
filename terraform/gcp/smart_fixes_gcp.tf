resource "google_container_cluster" "workload_cluster1" {
  name               = "terragoat-${var.environment}-cluster"
  logging_service = "none"
}

resource "google_container_cluster" "workload_cluster2" {
  name               = "terragoat-${var.environment}-cluster"
  logging_service = "logging.googleapis.com/kubernetes"
}


resource "google_container_cluster" "workload_cluster3" {
  name               = "terragoat-${var.environment}-cluster"
  logging_service = "logging.googleapis.com/kubernetes"
}

resource "google_container_cluster" "workload_cluster4" {
  name               = "terragoat-${var.environment}-cluster"
  logging_service = "logging.googleapis.com/kubernetes"
}

resource "google_container_cluster" "workload_cluster5" {
  name               = "terragoat-${var.environment}-cluster"
  logging_service = "logging.googleapis.com/kubernetes"
}

resource "google_container_cluster" "workload_cluster6" {
  name               = "terragoat-${var.environment}-cluster"
  logging_service = "logging.googleapis.com"
}

resource "google_container_cluster" "workload_cluster7" {
  name               = "terragoat-${var.environment}-cluster"
  logging_service = "logging.googleapis.com"
}

resource "google_container_cluster" "workload_cluster8" {
  name               = "terragoat-${var.environment}-cluster"
  logging_service = "logging.googleapis.com"
}
