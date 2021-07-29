# Provider
provider "azurerm" {
    version = "~>2.0"

    features {}
}

# # Remote Backend
# terraform {
#   backend "remote" {
#     organization = "jye-test-lab"

#     workspaces {
#       name = "Module-Test"
#     }
#   }
# }