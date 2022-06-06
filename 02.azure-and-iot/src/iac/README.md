# IaC

> :warning: :warning: :warning: 
> 
> THIS MODULES ARE NOT TESTED AND ARE NOT COMPLETE, USE IT AS DOCUMENTATION OR STARTING POINT.
> 
> DO NOT EXPECT TO RELEASE A COMPLETE WORKING INFRASTRUCTURE USING THEM.
> 
> :warning: :warning: :warning:

In this document you find a step-by-step guide to setup the resources on Azure that are needed for the [Azure IoT demo](../../06.demo.md).

## Prerequisites

- bash/zsh
- terraform
- kubectl
- AZ CLI
  - Azure Subscription

## Setup

Perform AZ CLI login and select the target subscription

```bash
az login                                            # complete the interactive procedure
az account list -o table                            # copy the subscription id
az account set --subscription <SUBSCRIPTION_ID>     # take a look at https://github.com/filariow/azs
```

Initialize terraform, plan and publish infrastructure

```bash
pushd iac/environment/dev
terraform init          # initialize project
terraform plan -out p   # inspect changes
terraform apply p       # if plan 'p' is ok, apply changes
popd
```

## More Links

- https://github.com/filariow/azs
- https://www.terraform.io/
- https://registry.terraform.io/providers/hashicorp/azurerm/latest
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
