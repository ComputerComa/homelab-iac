output "semaphore_test_vmid" {
  value = module.semaphore_test.vmid
}

output "semaphore_test_hostname" {
  value = module.semaphore_test.hostname
}

output "semaphore_test_ip" {
  value = module.semaphore_test.ip_address
}


output "netbox_vmid" {
  value = module.netbox.vmid
}

output "netbox_hostname" {
  value = module.netbox.hostname
}

output "netbox_ip" {
  value = module.netbox.ip_address
}

output "rundeck_hostname" {
  value = module.rundeck.hostname
}

output "rundeck_ip" {
  value = module.rundeck.ip_address
}

output "rundeck_vmid" {
  value = module.rundeck.vmid
}
