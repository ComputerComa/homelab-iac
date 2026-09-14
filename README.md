# homelab-iac

Starter Infrastructure-as-Code repository for a Proxmox homelab.

This repo is intentionally split by responsibility:

- **OpenTofu**: creates Proxmox infrastructure.
- **Ansible**: configures the guest after it exists.
- **Semaphore**: optional UI/orchestrator that runs the OpenTofu and Ansible jobs.
- **NetBox**: can be added later as the source of truth for IPAM/inventory.

The included example creates a disposable Debian 13 LXC:

- VMID: `199`
- Hostname: `semaphore-test`
- IP: `10.0.150.199/24`
- Gateway: `10.0.150.1`
- CPU: 1 core
- RAM: 1024 MB
- Disk: 8 GB

The LXC module derives the last octet of the IP from the VMID, matching the convention:

`VMID 199 -> 10.0.150.199`

## Repository layout

```text
homelab-iac/
├── tofu/
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tfvars.example
│   ├── variables.tf
│   ├── versions.tf
│   └── modules/
│       └── proxmox-lxc/
│           ├── main.tf
│           ├── outputs.tf
│           └── variables.tf
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   │   └── hosts.yml
│   └── playbooks/
│       └── nginx-test.yml
├── semaphore/
│   └── README.md
└── .gitignore
```

## Prerequisites

- OpenTofu 1.6+
- Proxmox VE supported by the `bpg/proxmox` provider
- A Debian 13 LXC template already downloaded to Proxmox
- A Proxmox API token
- SSH public key for the account that Ansible will use

The provider is pinned to `bpg/proxmox ~> 0.112`.

## 1. Create a Proxmox API token

Use a dedicated automation account/token rather than your root password.

Do **not** commit the token to Git.

For the starter lab, copy:

```bash
cd tofu
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with values appropriate for your Proxmox server.

Supply the API token through an environment variable:

```bash
export TF_VAR_proxmox_api_token='user@pam!tokenid=SECRET'
```

Semaphore can inject this as an environment variable instead.

## 2. Check the LXC template ID

On the Proxmox node:

```bash
pvesm list local | grep vztmpl
```

or:

```bash
pveam available | grep debian-13
```

Set `template_file_id` in `terraform.tfvars` to the actual storage ID, for example:

```hcl
template_file_id = "local:vztmpl/debian-13-standard_13.1-1_amd64.tar.zst"
```

The exact template filename varies. Do not blindly use the example value.

## 3. Test OpenTofu

```bash
cd tofu
tofu init
tofu fmt -recursive
tofu validate
tofu plan
```

If the plan looks right:

```bash
tofu apply
```

The starter configuration should create LXC `199` at `10.0.150.199`.

## 4. Test Ansible

After the LXC is reachable over SSH:

```bash
cd ../ansible
ansible all -m ping
ansible-playbook playbooks/nginx-test.yml
```

The playbook installs nginx, enables it, and verifies that it answers locally.

## 5. Tear down the test LXC

When finished:

```bash
cd ../tofu
tofu destroy
```

## Secrets and public GitHub repos

This repo is safe to make public **only if secrets and state remain outside Git**.

Never commit:

- Proxmox API tokens
- SSH private keys
- `.tfstate`
- `.env`
- Ansible Vault passwords
- database passwords
- cloud credentials

The `.gitignore` included here excludes the common dangerous files.

Keep `.terraform.lock.hcl` committed after the first `tofu init`.

## Next steps

Once the disposable test works:

1. Move each persistent service into a small module call.
2. Add a reusable Ansible `common` role.
3. Add application-specific roles such as `plane`.
4. Put the repo in GitHub.
5. Connect the repo to Semaphore.
6. Create Semaphore templates for:
   - `tofu plan`
   - `tofu apply`
   - `ansible-playbook`
   - `tofu destroy`
7. Add NetBox later when you want authoritative IPAM/inventory.
