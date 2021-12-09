data "hcloud_image" "github_runner" {
  with_selector = var.type
}

resource "random_pet" "name" {
  length = 2
  separator = "-"
}

resource "hcloud_server" "server" {
  name        = random_pet.name.id
  image       = data.hcloud_image.github_runner.id #The ID is displayed when the image is created
  server_type = var.server_type
  location    = var.location
  user_data   = "${file("files/cloud-init.yaml")}"

  network {
      network_id = var.network_id
  }
  }