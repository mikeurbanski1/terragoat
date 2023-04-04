data google_compute_zones "zones" {}

resource google_compute_instance "server" {
  machine_type = "n1-standard-1"
  name         = "terragoat-${var.environment}-machine"
  zone         = data.google_compute_zones.zones.names[0]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
    auto_delete = true
  }
  network_interface {
    subnetwork = google_compute_subnetwork.public-subnetwork.name
    access_config {}
  }
  can_ip_forward = true

  metadata = {
    block-project-ssh-keys = true
    serial-port-enable     = true
    enable-oslogin         = false
  }
  labels = {
    yor_trace = "1fb70e42-13d5-4d71-9bdd-74c28012b812"
  }
}



resource google_compute_disk "unencrypted_disk" {
  name = "terragoat-${var.environment}-disk"
  labels = {
    yor_trace = "08f7a92f-b2a6-4780-93c3-46525ab62150"
  }
}