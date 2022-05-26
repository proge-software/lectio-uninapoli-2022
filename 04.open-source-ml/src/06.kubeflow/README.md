# Kubeflow Demo

In this document you find a step-by-step guide to setup the resources on Azure that are needed for the [kubeflow the demo](../../06.kubeflow.md).

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

Once the deployment is completed, install kubeflow on the cluster

```bash
pushd kubeflow/
cat ./install_kubeflow.sh           # inspect the sh script before executing it
chmod +x install_kubeflow.sh
./install_kubeflow.sh
popd
```

## More Links

- https://github.com/filariow/azs
- https://www.terraform.io/
- https://registry.terraform.io/providers/hashicorp/azurerm/latest
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
