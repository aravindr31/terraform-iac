
resource "azurerm_resource_group" "storage-rg" {
  name     = "storage-rg"
  location = "southindia"
  tags     = {}
}

resource "azurerm_storage_account" "datastore" {
  name                      = "datastore4ci"
  resource_group_name       = azurerm_resource_group.storage-rg.name
  location                  = azurerm_resource_group.storage-rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  tags = {
    environment = "production"
  }
}

// Proxy manager fs

resource "azurerm_storage_share" "proxymanager-fs" {
  name                 = "fs4proxymanager"
  storage_account_name = azurerm_storage_account.datastore.name
  quota                = 1
}

// Vaultwarden fs

resource "azurerm_storage_share" "vaultwarden_fileshare" {
  name                 = "fs4vaultwarden"
  storage_account_name = azurerm_storage_account.datastore.name
  quota                = 1
}
