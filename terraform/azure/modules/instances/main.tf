resource "azurerm_network_interface" "server_nic" {
  name                = "pe-server-${count.index}-${var.id}"
  location            = var.region
  count               = var.server_count
  resource_group_name = var.resource_group.name
  tags                = var.tags

  ip_configuration {
    name                          = "server"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux_server" {
  name                   = "pe-server-${count.index}-${var.id}"
  count                  = var.server_count
  resource_group_name    = var.resource_group.name
  location               = var.region
  size                   = "Standard_D4_v4"
  admin_username         = var.user
  network_interface_ids  = [
    azurerm_network_interface.server_nic[count.index].id,
  ]

  depends_on = [
    azurerm_network_interface.server_nic
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 50
  }

  source_image_id = var.image

  tags  = merge({
    internalDNS = var.domain_name == null ? "pe-server-${count.index}-${var.id}.${azurerm_network_interface.server_nic[count.index].internal_domain_name_suffix}" : "pe-server-${count.index}-${var.id}.${var.domain_name}"
    name = "${var.id}-${count.index + 1}"
  }, var.tags)
}


resource "azurerm_network_interface" "windows_node_nic" {
  name                = "pe-windows-node-${count.index}-${var.id}"
  location            = var.region
  count               = var.windows_server_count
  resource_group_name = var.resource_group.name
  tags                = var.tags
  ip_configuration {
    name                          = "windows-node"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "windows_server" {
  name                   = "pe-windows-node-${count.index}-${var.id}"
  computer_name          = "pe-wn-${count.index}-${var.id}"
  count                  = var.windows_server_count
  resource_group_name    = var.resource_group.name
  location               = var.region
  size                   = "Standard_D4_v4"
  admin_username         = var.windows_user
  admin_password         = var.windows_password
  network_interface_ids  = [
    azurerm_network_interface.windows_node_nic[count.index].id,
  ]

  depends_on = [
    azurerm_network_interface.windows_node_nic
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_id = var.windows_image

  winrm_listener {
    protocol = "Http"
  }

  tags = merge({
    internalDNS = "pe-windows-node-${count.index}-${var.id}.${azurerm_network_interface.windows_node_nic[count.index].internal_domain_name_suffix}"
    name = "${var.id}-${count.index + 1}"
  }, var.tags)
}
