resource "azurerm_resource_group" "proxymanager-rg" {
  name     = "proxymanager-rg"
  location = "southindia"
  tags     = {}
}

resource "azurerm_container_group" "proxymanager-cg" {
  name     = "proxymanager-cg"
  location = azurerm_resource_group.proxymanager-rg.location

  resource_group_name = azurerm_resource_group.proxymanager-rg.name
  ip_address_type     = "Public"
  dns_name_label      = "proxymanager"
  os_type             = "Linux"

  container {
    name   = "proxymanager"
    image  = "docker.io/traefik:v3.1.0"
    cpu    = "0.5"
    memory = "0.5"

    ports {
      port     = 443
      protocol = "TCP"
    }
    ports {
      port     = 80
      protocol = "TCP"
    }

    ports {
      port     = 8080
      protocol = "TCP"
    }

    volume {
      name                 = "fs4proxymanager"
      mount_path           = "/traefik"
      read_only            = false
      storage_account_name = azurerm_storage_account.datastore.name
      storage_account_key  = azurerm_storage_account.datastore.primary_access_key
      share_name           = azurerm_storage_share.proxymanager-fs.name
    }
    commands = [
      "touch /traefik/acme.json && chmod 600 /traefik/acme.json && traefik",
      # "traefik --configFile=/traefik/traefik.yml",
    ]
    environment_variables = {
      # VAULT_FQDN = "${azurerm_container_group.bitwarden-cg.fqdn}"
      # API_URL    = "${var.DASHBOARD_URL}"
      # VAULT_URL  = "${var.VAULT_URL}"
    }

  }

  tags = {
    environment = "production"
  }

}
