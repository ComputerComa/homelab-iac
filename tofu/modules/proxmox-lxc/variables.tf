variable "node_name" {
  type = string
}

variable "datastore_id" {
  type = string
}

variable "template_file_id" {
  type = string
}

variable "vmid" {
  type = number

  validation {
    condition     = var.vmid >= 2 && var.vmid <= 254
    error_message = "For the VMID-to-last-octet convention, vmid must be between 2 and 254."
  }
}

variable "hostname" {
  type = string
}

variable "cores" {
  type    = number
  default = 1
}

variable "memory_mb" {
  type    = number
  default = 1024
}

variable "swap_mb" {
  type    = number
  default = 512
}

variable "disk_gb" {
  type    = number
  default = 8
}

variable "bridge" {
  type    = string
  default = "vmbr0"
}

variable "gateway" {
  type = string
}

variable "subnet_prefix" {
  type = string

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){2}[0-9]{1,3}$", var.subnet_prefix))
    error_message = "subnet_prefix must look like 10.0.150."
  }
}

variable "ssh_public_key" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "start_on_boot" {
  type    = bool
  default = true
}

variable "unprivileged" {
  type    = bool
  default = true
}

variable "enable_nesting" {
  type    = bool
  default = true
}

variable "prefix_length" {
  type    = number
  default = 16

  validation {
    condition     = var.prefix_length >= 1 && var.prefix_length <= 32
    error_message = "prefix_length must be between 1 and 32."
  }
}
