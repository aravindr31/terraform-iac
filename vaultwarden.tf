resource "azurerm_resource_group" "vaultwarden-rg" {
  name     = "vaultwarden-rg"
  location = "southindia"
  tags     = {}
}

resource "azurerm_container_group" "vaultwarden-cg" {
  name                = "vaultwarden-cg"
  location            = azurerm_resource_group.vaultwarden-rg.location
  resource_group_name = azurerm_resource_group.vaultwarden-rg.name
  ip_address_type     = "Public"
  dns_name_label      = "vaultwarden"
  os_type             = "Linux"

  container {
    name   = "vaultwarden"
    image  = "docker.io/vaultwarden/server:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }
    ports {
      port     = 80
      protocol = "TCP"
    }

    volume {
      name                 = "fs4vaultwarden"
      mount_path           = "/vw-data/"
      storage_account_name = azurerm_storage_account.datastore.name
      storage_account_key  = azurerm_storage_account.datastore.primary_access_key
      share_name           = azurerm_storage_share.vaultwarden_fileshare.name
    }

  }

  tags = {
    environment = "production"
  }
}
