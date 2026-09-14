locals {
  ip_address = "${var.subnet_prefix}.${var.vmid}/24"
}

resource "proxmox_virtual_environment_container" "this" {
  description = "Managed by OpenTofu"

  node_name = var.node_name
  vm_id     = var.vmid

  started       = true
  start_on_boot = var.start_on_boot
  unprivileged  = var.unprivileged

  tags = var.tags

  cpu {
    cores = var.cores
  }

  memory {
    dedicated = var.memory_mb
    swap      = var.swap_mb
  }

  disk {
    datastore_id = var.datastore_id
    size         = var.disk_gb
  }

  initialization {
    hostname = var.hostname

    ip_config {
      ipv4 {
        address = local.ip_address
        gateway = var.gateway
      }
    }

    user_account {
      keys = [
        trimspace(var.ssh_public_key)
      ]
    }
  }

  network_interface {
    name     = "veth0"
    bridge   = var.bridge
    enabled  = true
    firewall = false
  }

  operating_system {
    template_file_id = var.template_file_id
    type             = "debian"
  }

  features {
    nesting = var.enable_nesting
  }
}
