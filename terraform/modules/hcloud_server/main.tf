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
  user_data   = <<EOF

  #cloud-config
  runcmd:
    - cd "${var.runner_home}"
    - instance_id=$(cat /var/lib/cloud/data/instance-id)
    - sudo -u "${var.runner_user}" ./config.sh --unattended "${var.extra_flags}" --name "$instance_id" --url "https://github.com/${var.gh_repo}" --token "${var.runner_token}" --labels "$instance_id"
    - ./svc.sh install "${var.runner_user}"
    - ./svc.sh start

  EOF

  network {
      network_id = var.network_id
  }
  }