variable "proxmox_endpoint" {
  description = "Proxmox API endpoint, e.g. https://pve.example.internal:8006/"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API token in user@realm!tokenid=secret form. Inject with TF_VAR_proxmox_api_token."
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Allow an untrusted/self-signed Proxmox TLS certificate."
  type        = bool
  default     = true
}

variable "proxmox_node" {
  description = "Proxmox node on which the LXC will be created."
  type        = string
}

variable "datastore_id" {
  description = "Proxmox datastore for the LXC root disk."
  type        = string
  default     = "local-lvm"
}

variable "template_file_id" {
  description = "Existing Proxmox LXC template volume ID."
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key placed in root's authorized_keys in the test container."
  type        = string
}

variable "bridge" {
  description = "Proxmox bridge used by the container."
  type        = string
  default     = "vmbr0"
}

variable "gateway" {
  description = "IPv4 gateway for the 10.0.150.0/24 server network."
  type        = string
  default     = "10.0.150.1"
}

variable "subnet_prefix" {
  description = "First three octets used for the VMID-to-IP convention."
  type        = string
  default     = "10.0.150"
}
