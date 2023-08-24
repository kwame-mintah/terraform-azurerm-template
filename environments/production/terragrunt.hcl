# Terragrunt will copy the Terraform files from the locations specified into this directory
terraform {
  source = "../.."
}

locals {
  environment = "prod"
}

# These are inputs that need to be passed for the terragrunt configuration
inputs = {
  tags = {
    Terraform = "true"
    Environment = "${local.environment}"
  }
}

# (1) This block of code needs to be uncommented out first, before attempting to use the remote state/
remote_state {
  backend = "local"
  config = {
    path = "${local.environment}/${path_relative_to_include()}/terraform.tfstate"
  }
}

# (2) The terraform in this repository creates the storage account for things to be held.
# This could block will need to be populated with the following outputs
#    resource_group_name  = "<tfstate_resource_group_name>"
#    storage_account_name = "<tfstate_storage_account_name>"
#    container_name       = "<tfstate_storage_container_name>"
# After all configurations have been populated run `terragrunt init -migrate-state` in the directory
# When prompted, answer yes and will copy the state file to the storage account.
// remote_state {
//   backend = "azurerm"
//   config = {
//     key                  = "${local.environment}/${path_relative_to_include()}/terraform.tfstate"
//     resource_group_name  = ""
//     storage_account_name = ""
//     container_name       = ""
//   }
// }