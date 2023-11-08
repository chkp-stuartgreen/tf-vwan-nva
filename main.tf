resource "azurerm_resource_group" "rg-tf-demo-vwan" {
  name     = var.vwan-resource-group-name
  location = var.vwan-location
}

resource "azurerm_virtual_wan" "tf-demo-vwan" {
  name                = var.vwan-name
  resource_group_name = azurerm_resource_group.rg-tf-demo-vwan.name
  location            = azurerm_resource_group.rg-tf-demo-vwan.location
}

resource "azurerm_virtual_hub" "tf-demo-vwan-hub" {
  name                = var.vwan-hub-name
  resource_group_name = azurerm_resource_group.rg-tf-demo-vwan.name
  location            = azurerm_resource_group.rg-tf-demo-vwan.location
  address_prefix      = var.vwan-address-prefix
  virtual_wan_id      = azurerm_virtual_wan.tf-demo-vwan.id

}

resource "azurerm_managed_application" "tf-demo-ma-cpnva" {
  name                        = var.chkp-managed-app-name
  location                    = azurerm_resource_group.rg-tf-demo-vwan.location
  resource_group_name         = azurerm_resource_group.rg-tf-demo-vwan.name
  kind                        = "MarketPlace"
  managed_resource_group_name = var.chkp-managed-app-rg-name

  plan {
    name      = "vwan-app"
    product   = "azure-vwan"
    publisher = "checkpoint"
    version   = "1.0.3"
  }
  parameter_values = jsonencode({
    location = {
      value = azurerm_resource_group.rg-tf-demo-vwan.location
    },
    hubId = {
      value = azurerm_virtual_hub.tf-demo-vwan-hub.id
    },
    cloudGuardVersion = {
      value = var.chkp-cloudguard-version
    },
    imageVersion = {
      value = "latest"
    },
    scaleUnit = {
      value = var.chkp-scale-unit
    },
    bootstrapScript = {
      value = var.chkp-bootstrap-script
    },
    adminShell = {
      value = var.chkp-admin-shell
    },
    sicKey = {
      value = var.chkp-sic-key
    },
    sshPublicKey = {
      value = var.chkp-ssh-public-key
    },
    BGP = {
      value = var.chkp-bgp-asn
    },
    NVA = {
      value = var.chkp-nva-name
    },
    customMetrics = {
      value = var.chkp-custom-metrics
    },
    hubASN = {
      value = azurerm_virtual_hub.tf-demo-vwan-hub.virtual_router_asn
    },
    hubPeers = {
      value = azurerm_virtual_hub.tf-demo-vwan-hub.virtual_router_ips
    },
    smart1CloudTokenA = {
      value = var.chkp-smart1-cloud-token-a
    },
    smart1CloudTokenB = {
      value = var.chkp-smart1-cloud-token-b
    },
    smart1CloudTokenC = {
      value = var.chkp-smart1-cloud-token-c
    },
    smart1CloudTokenD = {
      value = var.chkp-smart1-cloud-token-d
    }
  })
}
