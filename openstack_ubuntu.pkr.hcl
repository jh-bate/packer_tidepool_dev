packer {
  required_plugins {
    openstack = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/openstack"
    }
  }
}

variables {
  os_auth_url          = env("OS_AUTH_URL")
  os_region_name       = env("OS_REGION_NAME")
  dest_image_name      = env("DEST_IMAGE_NAME")
  source_image_id      = env("SOURCE_IMAGE_ID")
  flavor_id            = env("FLAVOR_ID")
  floating_ip_network  = env("FLOATING_IP_NETWORK")
  network_id           = env("NETWORK_ID")
  security_group       = env("SECURITY_GROUP")
  security_group_first = env("CC_SECURITY_GROUP_ID")
}

source "openstack" "tidepool" {
  image_name          = var.dest_image_name
  source_image        = var.source_image_id
  flavor              = var.flavor_id
  floating_ip_network = var.floating_ip_network
  security_groups     = [var.security_group, var.security_group_first]
  ssh_username        = "ubuntu"
}

build {
  sources = ["source.openstack.tidepool"]

  provisioner "shell" {
    pause_before      = "30s"
    expect_disconnect = true
    scripts = [
      "./packer_templates/scripts/_tidepool/1_dependancies.sh",
      "./packer_templates/scripts/_tidepool/2_docker.sh",
      "./packer_templates/scripts/_tidepool/3_k8s.sh",
      "./packer_templates/scripts/_tidepool/4_mongo.sh",
    ]
  }

  provisioner "shell" {
    pause_before = "30s"
    inline       = ["TIDEPOOLDIR=$HOME/tidepool/development", "git clone https://github.com/tidepool-org/development.git $TIDEPOOLDIR", "export PATH=$TIDEPOOLDIR/bin:$PATH", "sudo systemctl stop cloud-init", "sudo rm -rf /var/lib/cloud/"]
  }
}

