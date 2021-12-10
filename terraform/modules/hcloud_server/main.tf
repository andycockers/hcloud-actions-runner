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
  ssh_keys    = ["andy@DESKTOP-CC1QGR9"]
  user_data   = <<EOF

  #cloud-config
  runcmd:
    - cd "$runner_home"
    - instance_id="\$(cat /var/lib/cloud/data/instance-id)"
    - sudo -u "$runner_user" ./config.sh --unattended "$extra_flags" --name "\$instance_id" --url "https://github.com/$GH_REPO" --token "$runner_token"
    - ./svc.sh install "$runner_user"
    - ./svc.sh start

  EOF

  network {
      network_id = var.network_id
  }
  }