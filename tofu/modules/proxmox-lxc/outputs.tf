output "vmid" {
  value = proxmox_virtual_environment_container.this.vm_id
}

output "hostname" {
  value = var.hostname
}

output "ip_address" {
  value = "${var.subnet_prefix}.${var.vmid}"
}
