# resource "azurerm_resource_group" "bitwarden-rg" {
#   name     = "bitwarden-rg"
#   location = "southindia"
#   tags     = {}
# }

# resource "azurerm_container_group" "bitwarden-cg" {
#   name                = "bitwarden-cg"
#   location            = azurerm_resource_group.bitwarden-rg.location
#   resource_group_name = azurerm_resource_group.bitwarden-rg.name
#   ip_address_type     = "Public"
#   dns_name_label      = "bitwarden"
#   os_type             = "Linux"

#   container {
#     name   = "bitwarden"
#     image  = "docker.io/vaultwarden/server:latest"
#     cpu    = "0.5"
#     memory = "1.5"

#     ports {
#       port     = 443
#       protocol = "TCP"
#     }
#     ports {
#       port     = 80
#       protocol = "TCP"
#     }

#     volume {
#       name                 = "fs4bitwarden"
#       mount_path           = "/vw-data/"
#       storage_account_name = azurerm_storage_account.datastore.name
#       storage_account_key  = azurerm_storage_account.datastore.primary_access_key
#       share_name           = azurerm_storage_share.bitwarden_fileshare.name
#     }
#     commands = []
#   }

#   tags = {
#     environment = "production"
#   }

# }

# output "vault-fqdn" {
#   value       = azurerm_container_group.bitwarden-cg.fqdn
#   description = "FQDN for vaultwarden"
# }
