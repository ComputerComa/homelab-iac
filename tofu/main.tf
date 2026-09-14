module "semaphore_test" {
  source = "./modules/proxmox-lxc"

  node_name        = var.proxmox_node
  datastore_id     = var.datastore_id
  template_file_id = var.template_file_id

  vmid     = 199
  hostname = "semaphore-test"

  cores     = 1
  memory_mb = 1024
  swap_mb   = 512
  disk_gb   = 8

bridge         = var.bridge
gateway        = var.gateway
subnet_prefix  = var.subnet_prefix
prefix_length  = var.prefix_length
ssh_public_key = var.ssh_public_key

  tags = [
    "managed-by-tofu",
    "semaphore-lab",
    "test"
  ]
}
