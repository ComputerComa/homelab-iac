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

module "netbox" {
  source = "./modules/proxmox-lxc"

  node_name        = var.proxmox_node
  datastore_id     = var.datastore_id
  template_file_id = var.template_file_id

  vmid     = 139
  hostname = "netbox"

  cores     = 2
  memory_mb = 4096
  swap_mb   = 512
  disk_gb   = 20

  bridge         = var.bridge
  gateway        = var.gateway
  subnet_prefix  = var.subnet_prefix
  prefix_length  = var.prefix_length
  ssh_public_key = var.ssh_public_key



  tags = [
    "managed-by-tofu",
    "netbox",
    "ipam",
    "dcim"
  ]
}

module "rundeck" {
  source = "./modules/proxmox-lxc"

  node_name   = var.proxmox_node
  vm_id       = 140
  hostname    = "rundeck"
  description = "Rundeck automation and job orchestration server"
  tags        = ["managed-by-tofu", "rundeck", "automation"]

  cores        = 2
  memory_mb    = 4096
  swap_mb      = 512
  disk_size_gb = 20

  network_prefix = "10.0.150"
  prefix_length  = 16
  gateway        = "10.0.1.1"
  dns_servers    = var.dns_servers

  ssh_public_key     = var.ssh_public_key
  container_template = var.container_template

  enable_nesting = false
}
