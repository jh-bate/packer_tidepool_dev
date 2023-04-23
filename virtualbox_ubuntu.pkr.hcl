packer {
  required_plugins {
    virtualbox = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

variables {
  os_name                        = "ubuntu"
  os_version                     = "22.04"
  os_arch                        = "x86_64"
  iso_url                        = "https://releases.ubuntu.com/jammy/ubuntu-22.04.2-live-server-amd64.iso"
  iso_checksum                   = "file:https://releases.ubuntu.com/jammy/SHA256SUMS"
  vmware_guest_os_type           = "ubuntu-64"
  boot_command                   = ["<wait>c<wait>set gfxpayload=keep<enter><wait>linux /casper/vmlinuz quiet autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/ ---<enter><wait>initrd /casper/initrd<wait><enter><wait>boot<enter><wait>"]
  boot_wait                      = "10s"
  vbox_guest_additions_path      = "VBoxGuestAdditions_22.04.iso"
  vbox_guest_additions_mode      = "upload"
  vbox_guest_additions_interface = "sata"
  vbox_iso_interface             = "sata"
  vbox_hard_drive_interface      = "sata"
  vbox_gfx_vram_size             = 33
  vbox_gfx_controller            = "vmsvga"
  vbox_guest_os_type             = "Ubuntu_64"
  cpus                           = 2
  disk_size                      = 65536
  communicator                   = "ssh"
  virtualbox_version_file        = ".vbox_version"
  http_directory                 = "./packer_templates/http"
  memory                         = 2048
  ssh_password                   = "vagrant"
  ssh_username                   = "vagrant"
  ssh_port                       = 22
  ssh_timeout                    = "60m"
  vm_name                        = "tidepool_local"
  output_directory               = "./builds/packer-ubuntu-virtualbox"
  headless                       = true
  vboxmanage = [
    [
      "modifyvm",
      "{{.Name}}",
      "--audio",
      "none",
      "--nat-localhostreachable1",
      "on",
    ]
  ]
  shutdown_command = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
}

source "virtualbox-iso" "vm" {
  gfx_controller            = var.vbox_gfx_controller
  gfx_vram_size             = var.vbox_gfx_vram_size
  guest_additions_path      = var.vbox_guest_additions_path
  guest_additions_mode      = var.vbox_guest_additions_mode
  guest_additions_interface = var.vbox_guest_additions_interface
  guest_os_type             = var.vbox_guest_os_type
  hard_drive_interface      = var.vbox_hard_drive_interface
  iso_interface             = var.vbox_iso_interface
  vboxmanage                = var.vboxmanage
  virtualbox_version_file   = var.virtualbox_version_file
  boot_command              = var.boot_command
  boot_wait                 = var.boot_wait
  cpus                      = var.cpus
  communicator              = var.communicator
  disk_size                 = var.disk_size
  headless                  = var.headless
  http_directory            = var.http_directory
  iso_checksum              = var.iso_checksum
  iso_url                   = var.iso_url
  memory                    = var.memory
  output_directory          = var.output_directory
  ssh_password              = var.ssh_password
  ssh_port                  = var.ssh_port
  ssh_timeout               = var.ssh_timeout
  ssh_username              = var.ssh_username
  vm_name                   = var.vm_name
  shutdown_command          = var.shutdown_command
}

build {
  sources = ["source.virtualbox-iso.vm"]

  provisioner "shell" {
    pause_before      = "30s"
    expect_disconnect = true
    execute_command   = "echo '${var.ssh_password}'|{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts = [
      "./packer_templates/scripts/ubuntu/update_ubuntu.sh",
      "./packer_templates/scripts/_common/sshd.sh",
      "./packer_templates/scripts/ubuntu/networking_ubuntu.sh",
      "./packer_templates/scripts/ubuntu/sudoers_ubuntu.sh",
      "./packer_templates/scripts/ubuntu/systemd_ubuntu.sh",
      "./packer_templates/scripts/_common/virtualbox.sh",
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

  provisioner "shell" {
    pause_before      = "30s"
    expect_disconnect = true
    execute_command   = "echo '${var.ssh_password}'|{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts = [
      "./packer_templates/scripts/ubuntu/cleanup_ubuntu.sh",
    ]
  }


}

