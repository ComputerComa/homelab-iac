# Semaphore setup notes

Semaphore should act as the runner/orchestrator. Git remains the source of truth.

## Repository

Add this Git repository to the Semaphore project.

If the GitHub repository is public, no repository credential is required.

## Secrets

Store the Proxmox API token and SSH private key in Semaphore's Key Store / environment configuration.

Do not add them to this Git repo.

For OpenTofu, expose the API token as:

```text
TF_VAR_proxmox_api_token
```

## Suggested templates

### 01 - Tofu Plan

Working directory:

```text
tofu
```

Commands:

```bash
tofu init
tofu fmt -check -recursive
tofu validate
tofu plan
```

### 02 - Tofu Apply

Working directory:

```text
tofu
```

Command:

```bash
tofu apply -auto-approve
```

For real infrastructure, remove `-auto-approve` unless the approval happens in Semaphore.

### 03 - Ansible Configure

Working directory:

```text
ansible
```

Command:

```bash
ansible-playbook playbooks/nginx-test.yml
```

### 04 - Tofu Destroy

Working directory:

```text
tofu
```

Command:

```bash
tofu destroy -auto-approve
```

Keep this manual while experimenting.

## Suggested first workflow

```text
Tofu Apply
    |
    v
Ansible Configure
```

Do not automatically chain `Destroy` until you are comfortable with Semaphore workflows.

## State warning

The starter repo uses local OpenTofu state.

That is fine for one-user experimentation, but once Semaphore becomes your real runner, move state to a durable remote backend or otherwise persist the Semaphore workspace. Losing state can make OpenTofu lose track of resources it created.
