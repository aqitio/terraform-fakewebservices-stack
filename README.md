# Terraform Fake Web Services Stack

This Terraform module provisions resources to a fictitious cloud provider using the [Fake Web Services](https://github.com/hashicorp/terraform-provider-fakewebservices) Terraform provider.

These resources are purely for demonstration purposes and are created in Terraform Cloud using an API token.

---

## Table of Contents
- [Prerequisites](#prerequisites)
- [Useful Resources](#useful-resources)
- [Configuration Example](#configuration-example)

---

## Prerequisites

> **Important**
>
>This guide assumes that you have already [created an Organization](https://www.terraform.io/cloud-docs/users-teams-organizations/organizations#creating-organizations) in Terraform Cloud and that you have access to a Version Control System (VCS) repository containing Terraform configuration.

### VCS Settings
Terraform Cloud provides first-class support for VCS integration. This allows VCS repositories to contain all of the policies and configuration needed to manage Terraform at scale.

To [Integrate with VCS](https://www.terraform.io/docs/cloud/getting-started/policies.html#integrating-with-vcs):

1. [Connect a VCS Provider to Terraform Cloud](https://www.terraform.io/docs/cloud/vcs/index.html)
2. **Create** a repository in your VCS provider that contains a copy of the [example](./example/) Terraform configuration
3. **Clone** the source repository to a local directory (optional)

### User Settings
To view your settings, click your user icon and select User settings. Your Profile page appears, showing your username, email address, and avatar.

Create a new token:

1. Click **Create an API token**. The **Create API token** box appears.
2. Enter a **Description** that explains what the token is for and click **Create API token**.
3. Copy your token from the box and save it in a secure location. Terraform Cloud only displays the token once, right after you create it. If you lose it, you must revoke the old token and create a new one.

### Workspace Settings
To view your workspaces, Click **Workspaces** in the top navigation bar. Terraform Cloud shows a list of all workspaces in the current organization.

> **Note**
>
>The workspace creation process varies depending on the workflow you choose. The following steps assume that you will connect a Terraform Cloud workspace to a version control system (VCS) repository that contains Terraform configuration.

Create a workspace:

1. Click **Workspaces** in the top navigation bar to view a list of the workspaces within your organization.
2. Click **+ New Workspace**. The **Create a new Workspace** page appears.
3. Choose **Version control** as the workflow type.
4. Choose an existing version control provider or configure a new one. Refer to [Connecting VCS Providers](https://www.terraform.io/cloud-docs/vcs) for more details.
5. Choose the repository that you created in the [VCS Settings](#vcs-settings) section of this guide. The **Configure settings** page appears.
6. Enter a **Workspace Name**. This defaults to the repository name, if applicable.
7. Add an optional **Description** that will appear at the top of the workspace in the Terraform Cloud UI.
8. Open **Advanced options** to optionally configure the following settings:
    - [Terraform Working Directory](https://www.terraform.io/cloud-docs/workspaces/settings#terraform-working-directory)
    - [Automatic Run Triggering](https://www.terraform.io/cloud-docs/workspaces/settings/vcs#automatic-run-triggering)
    - [VCS branch](https://www.terraform.io/cloud-docs/workspaces/settings/vcs#vcs-branch)
    - [Include submodules on clone](https://www.terraform.io/cloud-docs/workspaces/settings/vcs#include-submodules-on-clone)
9. Click **Create workspace**.

### Workspace Variables
To view and manage the workspace's variables, go to the workspace and click the **Variables** tab.

Add a **server_count** variable:

1. Go to the workspace **Variables** page and click **+ Add variable** in the Workspace Variables section.
2. Choose the **Terraform variable** category, and enter `server_count` as the **Key**, and `4` as the **Value**.
3. Click **Save variable**. The variable now appears in the list of the workspace's variables

Add a **fake_token** variable:

1. Go to the workspace **Variables** page and click **+ Add variable** in the Workspace Variables section.
2. Choose the **Environment variable** category, and enter `fake_token` as the **Key**, and your `API token` as the **Value**.
3. Mark the variable as **sensitive** and click **Save variable**.

Add a **fws_hostname** variable:

1. Go to the workspace **Variables** page and click **+ Add variable** in the Workspace Variables section.
2. Choose the **Environment variable** category, and enter `fws_hostname` as the **Key**, and `app.terraform.io` as the **Value**.
3. Mark the variable as **sensitive** and click **Save variable**.

---

## Useful Resources

↥ [back to top](#table-of-contents)

- [Getting Started with Terraform Cloud](https://www.terraform.io/docs/cloud/getting-started/index.html)
- [Configuring Version Control Access](https://www.terraform.io/docs/cloud/getting-started/vcs.html)
- [Workspaces](https://www.terraform.io/cloud-docs/workspaces#workspaces)
- [Viewing and Managing Runs](https://www.terraform.io/cloud-docs/run/manage)
- [The UI/VCS-driven Run Workflow](https://www.terraform.io/cloud-docs/run/ui)

---

## Configuration Example

↥ [back to top](#table-of-contents)

**main.tf**
```hcl
// Providers
terraform {
  required_providers {
    fakewebservices = {
      source  = "hashicorp/fakewebservices"
      version = "0.2.3"
    }
  }
}

provider "fakewebservices" {
  hostname = var.fws_hostname
  token    = var.fake_token
}

// Variables
variable "fws_hostname" {
  type        = string
  description = "The Terraform Cloud/Enterprise hostname that will be used in the provider configuration block."
}

variable "fake_token" {
  type        = string
  sensitive   = true
  description = "The Terraform Cloud/Enterprise user/team token that will be used in the provider configuration block."
}

variable "server_count" {
    description = "The number of fakewebservices_server resources that will get provisioned."
}

// Main
module "stack" {
  source         = "aqitio/stack/fakewebservices"
  version        = "~> 0.0.8"
  stack_prefix   = "ENV"
  server_count   = var.server_count
  server_type    = "t2.micro"
  database_size  = 256
  vpc_cidr_block = "0.0.0.0/1"
}
